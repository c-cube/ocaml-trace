open Common_
open Trace_core
open Trace_private_util
module Span_sub = Sub.Span_sub

module Buf_pool = struct
  type t = Buffer.t Rpool.t

  let create ?(max_size = 32) ?(buf_size = 256) () : t =
    Rpool.create ~max_size ~clear:Buffer.reset
      ~create:(fun () -> Buffer.create buf_size)
      ()
end

open struct
  let[@inline] time_us_of_time_ns (t : int64) : float =
    Int64.div t 1_000L |> Int64.to_float
end

let on_tracing_error = ref (fun s -> Printf.eprintf "%s\n%!" s)

(*
type span_info = {
  tid: int;
  name: string;
  start_us: float;
  mutable data: (string * user_data) list;
      (* NOTE: thread safety: this is supposed to only be modified by the thread
that's running this (synchronous, stack-abiding) span. *)
}
(** Information we store about a span begin event, to emit a complete event when
    we meet the corresponding span end event *)
*)

type t = {
  active: bool A.t;
  pid: int;
  buf_pool: Buf_pool.t;
  exporter: Exporter.t;
  span_id_gen: Sub.Span_id_generator.t;
  trace_id_gen: Sub.Trace_id_generator.t;
}
(** Subscriber state *)

(* TODO: this is nice to have, can we make it optional?
open struct
  let print_non_closed_spans_warning spans =
    let module Str_set = Set.Make (String) in
    let spans = Span_tbl.to_list spans in
    if spans <> [] then (
      !on_tracing_error
      @@ Printf.sprintf "trace-tef: warning: %d spans were not closed"
           (List.length spans);
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
end
*)

let close (self : t) : unit =
  if A.exchange self.active false then
    (* FIXME: print_non_closed_spans_warning self.spans; *)
    self.exporter.close ()

let[@inline] active self = A.get self.active
let[@inline] flush (self : t) : unit = self.exporter.flush ()

let create ?(buf_pool = Buf_pool.create ()) ~pid ~exporter () : t =
  {
    active = A.make true;
    exporter;
    buf_pool;
    pid;
    span_id_gen = Sub.Span_id_generator.create ();
    trace_id_gen = Sub.Trace_id_generator.create ();
  }

open struct
  type st = t

  let new_span_id (self : st) = Sub.Span_id_generator.gen self.span_id_gen
  let new_trace_id (self : st) = Sub.Trace_id_generator.gen self.trace_id_gen
  let on_init _ ~time_ns:_ = ()
  let on_shutdown (self : st) ~time_ns:_ = close self

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", `String f) :: data

  let on_enter_span (self : st) (span : Span_sub.t) : unit =
    match span.flavor with
    | `Async ->
      let { Span_sub.time_ns; data; tid; name; _ } = span in
      let time_us = time_us_of_time_ns time_ns in
      let data = add_fun_name_ span.__FUNCTION__ data in
      let@ buf = Rpool.with_ self.buf_pool in
      Writer.emit_begin buf ~pid:self.pid ~tid ~name ~id:span.trace_id
        ~ts:time_us ~args:data ~flavor:span.flavor;
      self.exporter.on_json buf
    | `Sync -> () (* done at exit *)

  let on_exit_span (self : st) ~time_ns:exit_time_ns ~tid:_ span : unit =
    let { Span_sub.data; tid; flavor; name; _ } = span in
    let exit_time_us = time_us_of_time_ns exit_time_ns in

    let@ buf = Rpool.with_ self.buf_pool in
    (match flavor with
    | `Sync ->
      (* emit full event *)
      let start_time_us = time_us_of_time_ns span.time_ns in
      Writer.emit_duration_event buf ~pid:self.pid ~tid ~name
        ~start:start_time_us ~end_:exit_time_us ~args:data
    | `Async ->
      Writer.emit_end buf ~pid:self.pid ~tid ~name ~id:span.trace_id
        ~ts:exit_time_us ~flavor ~args:data);

    self.exporter.on_json buf

  let on_message (self : st) ~time_ns ~tid ~span:_ ~params:_ ~data msg : unit =
    let time_us = time_us_of_time_ns @@ time_ns in
    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_instant_event buf ~pid:self.pid ~tid ~name:msg ~ts:time_us
      ~args:data;
    self.exporter.on_json buf

  let on_counter (self : st) ~time_ns ~tid ~params:_ ~data:_ ~name n : unit =
    let time_us = time_us_of_time_ns @@ time_ns in
    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_counter buf ~pid:self.pid ~name ~tid ~ts:time_us n;
    self.exporter.on_json buf

  let on_name_thread_ (self : st) ~tid name : unit =
    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_name_thread buf ~pid:self.pid ~tid ~name;
    self.exporter.on_json buf

  let on_name_process_ (self : st) name : unit =
    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_name_process ~pid:self.pid ~name buf;
    self.exporter.on_json buf

  let on_extension_event (self : st) ~time_ns:_ ~tid ev =
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
