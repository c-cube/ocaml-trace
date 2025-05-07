open Common_
open Trace_core
module Span_tbl = Trace_subscriber.Span_tbl

let on_tracing_error = on_tracing_error

type span_info = {
  tid: int;
  name: string;
  start_ns: int64;
  mutable data: (string * Sub.user_data) list;
      (* NOTE: thread safety: this is supposed to only be modified by the thread
      that's running this (synchronous, stack-abiding) span. *)
}
(** Information we store about a span begin event, to emit a complete event when
    we meet the corresponding span end event *)

type t = {
  active: bool A.t;
  pid: int;
  spans: span_info Span_tbl.t;
  buf_chain: Buf_chain.t;
  exporter: Exporter.t;
}
(** Subscriber state *)

open struct
  (** Write the buffers that are ready *)
  let[@inline] write_ready_ (self : t) =
    if Buf_chain.has_ready self.buf_chain then
      Buf_chain.pop_ready self.buf_chain ~f:self.exporter.write_bufs

  let print_non_closed_spans_warning spans =
    let module Str_set = Set.Make (String) in
    let spans = Span_tbl.to_list spans in
    if spans <> [] then (
      !on_tracing_error
      @@ Printf.sprintf "trace-tef: warning: %d spans were not closed\n"
           (List.length spans);
      let names =
        List.fold_left
          (fun set (_, span) -> Str_set.add span.name set)
          Str_set.empty spans
      in
      Str_set.iter
        (fun name ->
          !on_tracing_error @@ Printf.sprintf "  span %S was not closed\n" name)
        names;
      flush stderr
    )
end

let close (self : t) : unit =
  if A.exchange self.active false then (
    Buf_chain.ready_all_non_empty self.buf_chain;
    write_ready_ self;
    self.exporter.close ();

    print_non_closed_spans_warning self.spans
  )

let[@inline] active self = A.get self.active

let flush (self : t) : unit =
  Buf_chain.ready_all_non_empty self.buf_chain;
  write_ready_ self;
  self.exporter.flush ()

let create ?(buf_pool = Buf_pool.create ()) ~pid ~exporter () : t =
  let buf_chain = Buf_chain.create ~sharded:true ~buf_pool () in
  { active = A.make true; buf_chain; exporter; pid; spans = Span_tbl.create () }

module Callbacks = struct
  type st = t

  let on_init (self : st) ~time_ns:_ =
    Writer.Metadata.Magic_record.encode self.buf_chain;
    Writer.Metadata.Initialization_record.(
      encode self.buf_chain ~ticks_per_secs:default_ticks_per_sec ());
    Writer.Metadata.Provider_info.encode self.buf_chain ~id:0
      ~name:"ocaml-trace" ();
    (* make sure we write these immediately so they're not out of order *)
    Buf_chain.ready_all_non_empty self.buf_chain;

    write_ready_ self

  let on_shutdown (self : st) ~time_ns:_ = close self

  let on_name_process (self : st) ~time_ns:_ ~tid:_ ~name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_process ~kid:self.pid ~args:[] ());
    write_ready_ self

  let on_name_thread (self : st) ~time_ns:_ ~tid ~name : unit =
    Writer.Kernel_object.(
      encode self.buf_chain ~name ~ty:ty_thread ~kid:tid
        ~args:[ "process", A_kid (Int64.of_int self.pid) ]
        ());
    write_ready_ self

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", Sub.U_string f) :: data

  let[@inline] on_enter_span (self : st) ~__FUNCTION__:fun_name ~__FILE__:_
      ~__LINE__:_ ~time_ns ~tid ~data ~name span : unit =
    let data = add_fun_name_ fun_name data in
    let info = { tid; name; start_ns = time_ns; data } in
    (* save the span so we find it at exit *)
    Span_tbl.add self.spans span info

  let on_exit_span (self : st) ~time_ns ~tid:_ span : unit =
    match Span_tbl.find_exn self.spans span with
    | exception Not_found ->
      !on_tracing_error (Printf.sprintf "cannot find span %Ld" span)
    | { tid; name; start_ns; data } ->
      Span_tbl.remove self.spans span;
      Writer.(
        Event.Duration_complete.encode self.buf_chain ~name
          ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
          ~time_ns:start_ns ~end_time_ns:time_ns ~args:(args_of_user_data data)
          ());
      write_ready_ self

  let on_add_data (self : st) ~data span =
    if data <> [] then (
      try
        let info = Span_tbl.find_exn self.spans span in
        info.data <- List.rev_append data info.data
      with Not_found ->
        !on_tracing_error (Printf.sprintf "cannot find span %Ld" span)
    )

  let on_message (self : st) ~time_ns ~tid ~span:_ ~data msg : unit =
    Writer.(
      Event.Instant.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name:msg ~time_ns ~args:(args_of_user_data data) ());
    write_ready_ self

  let on_counter (self : st) ~time_ns ~tid ~data ~name n : unit =
    Writer.(
      Event.Counter.encode self.buf_chain
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~name ~time_ns
        ~args:((name, A_float n) :: args_of_user_data data)
        ());
    write_ready_ self

  let on_enter_manual_span (self : st) ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_
      ~time_ns ~tid ~parent:_ ~data ~name ~flavor:_ ~trace_id _span : unit =
    Writer.(
      Event.Async_begin.encode self.buf_chain ~name
        ~args:(args_of_user_data data)
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~time_ns ~async_id:trace_id ());
    write_ready_ self

  let on_exit_manual_span (self : st) ~time_ns ~tid ~name ~data ~flavor:_
      ~trace_id (_ : span) : unit =
    Writer.(
      Event.Async_end.encode self.buf_chain ~name ~args:(args_of_user_data data)
        ~t_ref:(Thread_ref.inline ~pid:self.pid ~tid)
        ~time_ns ~async_id:trace_id ());
    write_ready_ self

  let on_extension_event _ ~time_ns:_ ~tid:_ _ev = ()
end

let subscriber (self : t) : Sub.t =
  Sub.Subscriber.Sub { st = self; callbacks = (module Callbacks) }
