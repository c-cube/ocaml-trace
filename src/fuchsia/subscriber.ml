open Common_
open Trace_core

let on_tracing_error = on_tracing_error

type t = {
  active: bool A.t;
  pid: int;
  buf_chain: Buf_chain.t;
  exporter: Exporter.t;
  span_id_gen: Sub.Span_id_generator.t;
  trace_id_gen: Sub.Trace_id_generator.t;
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
    span_id_gen = Sub.Span_id_generator.create ();
    trace_id_gen = Sub.Trace_id_generator.create ();
  }

open struct
  let new_span_id (self : t) = Sub.Span_id_generator.gen self.span_id_gen
  let new_trace_id self = Sub.Trace_id_generator.gen self.trace_id_gen

  let on_init (self : t) ~time_ns:_ =
    Writer.Metadata.Magic_record.encode self.buf_chain;
    Writer.Metadata.Initialization_record.(
      encode self.buf_chain ~ticks_per_secs:default_ticks_per_sec ());
    Writer.Metadata.Provider_info.encode self.buf_chain ~id:0
      ~name:"ocaml-trace" ();
    (* make sure we write these immediately so they're not out of order *)
    Buf_chain.ready_all_non_empty self.buf_chain;

    write_ready_ self

  let on_shutdown (self : t) ~time_ns:_ = close self

  let on_name_process_ (self : t) name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_process ~kid:self.pid ~args:[] ());
    write_ready_ self

  let on_name_thread_ (self : t) ~tid name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_thread ~kid:tid
        ~args:[ "process", A_kid (Int64.of_int self.pid) ]
        ());
    write_ready_ self

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", `String f) :: data

  let on_enter_span (self : t) (span : Sub.Span_sub.t) : unit =
    let { Sub.Span_sub.data; name; tid; time_ns; flavor; _ } = span in
    match flavor with
    | `Sync -> ()
    | `Async ->
      let data = add_fun_name_ span.__FUNCTION__ data in
      Writer.(
        Event.Async_begin.encode self.buf_chain ~name
          ~args:(args_of_user_data data)
          ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
          ~time_ns ~async_id:span.trace_id ());
      write_ready_ self

  let on_exit_span (self : t) ~time_ns:end_time_ns ~tid:_
      (span : Sub.Span_sub.t) : unit =
    let { Sub.Span_sub.tid; name; flavor; time_ns = start_ns; data; _ } =
      span
    in
    let data = add_fun_name_ span.__FUNCTION__ data in

    match flavor with
    | `Sync ->
      Writer.(
        Event.Duration_complete.encode self.buf_chain ~name
          ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
          ~time_ns:start_ns ~end_time_ns ~args:(args_of_user_data data) ());
      write_ready_ self
    | `Async ->
      Writer.(
        Event.Async_end.encode self.buf_chain ~name
          ~args:(args_of_user_data data)
          ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
          ~time_ns:end_time_ns ~async_id:span.trace_id ());
      write_ready_ self

  let on_message (self : t) ~time_ns ~tid ~span:_ ~params:_ ~data msg : unit =
    Writer.(
      Event.Instant.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name:msg ~time_ns ~args:(args_of_user_data data) ());
    write_ready_ self

  let on_counter (self : t) ~time_ns ~tid ~params:_ ~data ~name n : unit =
    Writer.(
      Event.Counter.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name ~time_ns
        ~args:((name, A_float n) :: args_of_user_data data)
        ());
    write_ready_ self

  let on_extension_event (self : t) ~time_ns:_ ~tid ev =
    match ev with
    | Core_ext.Extension_set_thread_name name -> on_name_thread_ self ~tid name
    | Core_ext.Extension_set_process_name name -> on_name_process_ self name
    | _ -> ()
end

let sub_callbacks : _ Sub.Callbacks.t =
  Sub.Callbacks.make ~new_span_id ~new_trace_id ~on_init ~on_shutdown
    ~on_enter_span ~on_exit_span ~on_message ~on_counter ~on_extension_event ()

let subscriber (self : t) : Sub.t =
  Sub.Subscriber.Sub { st = self; callbacks = sub_callbacks }
