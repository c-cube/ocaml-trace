open Common_
open Types
open Trace_core

type t = {
  active: bool A.t;
  pid: int;
  buf_chain: Buf_chain.t;
  exporter: Exporter.t;
  trace_id_gen: Types.Trace_id.Gen.t;
}
(** Subscriber state *)

open struct
  (** Write the buffers that are ready *)
  let[@inline] write_ready_ (self : t) =
    if Buf_chain.has_ready self.buf_chain then
      Buf_chain.pop_ready self.buf_chain ~f:self.exporter.write_bufs

  (* TODO: nice to have, can we make it optional?
  let print_non_closed_spans_warning spans =
    let module Str_set = Set.Make (String) in
    let spans = Span_tbl.to_list spans in
    if spans <> [] then (
      !on_tracing_error
      @@ Printf.sprintf "warning: %d spans were not closed" (List.length spans);
      let names =
        List.fold_left
          (fun set (_, span) -> Str_set.add span.name set)
          Str_set.empty spans
      in
      Str_set.iter
        (fun name ->
          !on_tracing_error @@ Printf.sprintf "  span %S was not closed" name)
        names;
      flush stderr
    )
    *)
end

let close (self : t) : unit =
  if A.exchange self.active false then (
    Buf_chain.ready_all_non_empty self.buf_chain;
    write_ready_ self;
    self.exporter.close () (* TODO: print_non_closed_spans_warning self.spans *)
  )

let[@inline] active self = A.get self.active

let flush (self : t) : unit =
  Buf_chain.ready_all_non_empty self.buf_chain;
  write_ready_ self;
  self.exporter.flush ()

let create ?(buf_pool = Buf_pool.create ()) ~pid ~exporter () : t =
  let buf_chain = Buf_chain.create ~sharded:true ~buf_pool () in
  {
    active = A.make true;
    buf_chain;
    exporter;
    pid;
    trace_id_gen = Types.Trace_id.Gen.create ();
  }

open struct
  let new_trace_id self = Types.Trace_id.Gen.gen self.trace_id_gen

  let init (self : t) =
    Writer.Metadata.Magic_record.encode self.buf_chain;
    Writer.Metadata.Initialization_record.(
      encode self.buf_chain ~ticks_per_secs:default_ticks_per_sec ());
    Writer.Metadata.Provider_info.encode self.buf_chain ~id:0
      ~name:"ocaml-trace" ();
    (* make sure we write these immediately so they're not out of order *)
    Buf_chain.ready_all_non_empty self.buf_chain;

    write_ready_ self

  let shutdown (self : t) = close self

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", `String f) :: data

  let rec flavor_of_params = function
    | [] -> `Sync
    | Core_ext.Extension_span_flavor f :: _ -> f
    | _ :: tl -> flavor_of_params tl

  let enter_span (self : t) ~__FUNCTION__ ~__FILE__ ~__LINE__ ~params ~data
      ~parent name : span =
    let flavor = flavor_of_params params in
    let time_ns = Trace_util.Mock_.now_ns () in
    let tid = Trace_util.Mock_.get_tid () in

    match flavor with
    | `Sync ->
      Span_fuchsia_sync
        {
          __FUNCTION__;
          name;
          pid = self.pid;
          tid;
          args = data;
          start_ns = time_ns;
        }
    | `Async ->
      let data = add_fun_name_ __FUNCTION__ data in
      let trace_id =
        match parent with
        | P_some (Span_fuchsia_async sp) -> sp.trace_id
        | _ -> new_trace_id self
      in

      Writer.(
        Event.Async_begin.encode self.buf_chain ~name
          ~args:(args_of_user_data data)
          ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
          ~time_ns ~async_id:trace_id ());
      write_ready_ self;

      Span_fuchsia_async { pid = self.pid; tid; trace_id; name; args = data }

  let exit_span (self : t) sp =
    let end_time_ns = Trace_util.Mock_.now_ns () in

    match sp with
    | Span_fuchsia_sync { __FUNCTION__; name; tid; pid; args = data; start_ns }
      ->
      let data = add_fun_name_ __FUNCTION__ data in
      Writer.(
        Event.Duration_complete.encode self.buf_chain ~name
          ~t_ref:(Thread_ref.inline ~pid ~tid)
          ~time_ns:start_ns ~end_time_ns ~args:(args_of_user_data data) ());
      write_ready_ self
    | Span_fuchsia_async { name; tid; pid; trace_id; args = data } ->
      Writer.(
        Event.Async_end.encode self.buf_chain ~name
          ~args:(args_of_user_data data)
          ~t_ref:(Thread_ref.inline ~pid ~tid)
          ~time_ns:end_time_ns ~async_id:trace_id ());
      write_ready_ self
    | _ -> ()

  let add_data_to_span _st sp data =
    match sp with
    | Span_fuchsia_sync sp -> sp.args <- List.rev_append data sp.args
    | Span_fuchsia_async sp -> sp.args <- List.rev_append data sp.args
    | _ -> ()

  let message (self : t) ~params:_ ~data ~span:_ msg : unit =
    let time_ns = Trace_util.Mock_.now_ns () in
    let tid = Trace_util.Mock_.get_tid () in
    Writer.(
      Event.Instant.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name:msg ~time_ns ~args:(args_of_user_data data) ());
    write_ready_ self

  let counter_float (self : t) ~params:_ ~data name n : unit =
    let tid = Trace_util.Mock_.get_tid () in
    let time_ns = Trace_util.Mock_.now_ns () in
    Writer.(
      Event.Counter.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name ~time_ns
        ~args:((name, A_float n) :: args_of_user_data data)
        ());
    write_ready_ self

  let counter_int self ~params:_ ~data name n =
    let tid = Trace_util.Mock_.get_tid () in
    let time_ns = Trace_util.Mock_.now_ns () in
    Writer.(
      Event.Counter.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name ~time_ns
        ~args:((name, A_int n) :: args_of_user_data data)
        ());
    write_ready_ self

  let name_process_ (self : t) name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_process ~kid:self.pid ~args:[] ());
    write_ready_ self

  let name_thread_ (self : t) ~tid name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_thread ~kid:tid
        ~args:[ "process", A_kid (Int64.of_int self.pid) ]
        ());
    write_ready_ self

  let extension (self : t) ev =
    match ev with
    | Core_ext.Extension_set_thread_name name ->
      let tid = Trace_util.Mock_.get_tid () in
      name_thread_ self ~tid name
    | Core_ext.Extension_set_process_name name -> name_process_ self name
    | _ -> ()
end

let callbacks : t Collector.Callbacks.t =
  Collector.Callbacks.make ~init ~shutdown ~enter_span ~exit_span
    ~add_data_to_span ~message ~counter_int ~counter_float ~extension ()

let collector (self : t) : Collector.t = Collector.C_some (self, callbacks)
