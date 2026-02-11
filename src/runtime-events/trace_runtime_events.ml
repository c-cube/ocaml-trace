(** Simple backend that emits trace events via Runtime_events.

    This backend allows trace spans, messages, and metrics to be collected by
    external tools using the OCaml Runtime_events system. *)

open Trace_core

(* Register custom event types for strings *)
module String_type = struct
  let max_len = 1024

  let encode buf s =
    let len = min (String.length s) (max_len - 1) in
    Bytes.blit_string s 0 buf 0 len;
    len

  let decode buf len = Bytes.sub_string buf 0 len
  let ty = Runtime_events.Type.register ~encode ~decode
end

module String_int = struct
  let max_len = 1024

  let encode buf (s, i) =
    let len = min (String.length s) (max_len - 9) in
    Bytes.set_int64_le buf 0 (Int64.of_int i);
    Bytes.blit_string s 0 buf 8 len;
    len + 8

  let decode buf len =
    let i = Bytes.get_int64_le buf 0 in
    Bytes.sub_string buf 8 (len - 8), Int64.to_int i

  let ty = Runtime_events.Type.register ~encode ~decode
end

module String_float = struct
  let max_len = 1024

  let encode buf (s, f) =
    let len = min (String.length s) (max_len - 9) in
    Bytes.set_int64_le buf 0 (Int64.bits_of_float f);
    Bytes.blit_string s 0 buf 8 len;
    len + 8

  let decode buf len =
    let i = Bytes.get_int64_le buf 0 in
    Bytes.sub_string buf 8 (len - 8), Int64.float_of_bits i

  let ty = Runtime_events.Type.register ~encode ~decode
end

module Events = struct
  (* Define event tags *)
  type Runtime_events.User.tag +=
    | Tag_span_enter
    | Tag_span_exit
    | Tag_message
    | Tag_metric_int
    | Tag_metric_float

  (* Register user events *)
  let span_enter_event =
    Runtime_events.User.register "trace.span.enter" Tag_span_enter
      String_type.ty

  let span_exit_event =
    Runtime_events.User.register "trace.span.exit" Tag_span_exit String_type.ty

  let message_event =
    Runtime_events.User.register "trace.message" Tag_message String_type.ty

  let metric_int_event =
    Runtime_events.User.register "trace.metric.int" Tag_metric_int String_int.ty

  let metric_float_event =
    Runtime_events.User.register "trace.metric.float" Tag_metric_float
      String_float.ty
end

(* Span representation *)
type span_info = { name: string }
type Trace_core.span += Span_runtime_events of span_info

(* Collector state *)
type st = {
  active: bool Trace_core.Internal_.Atomic_.t;
  start_events: bool;
}

let create ?(start_events = true) () : st =
  { active = Trace_core.Internal_.Atomic_.make true; start_events }

(* Collector callbacks *)
let init (self : st) = if self.start_events then Runtime_events.start ()

let shutdown (self : st) =
  Trace_core.Internal_.Atomic_.set self.active false;
  Runtime_events.pause ()

let enabled _ _ = true

let enter_span (_self : st) ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~level:_
    ~params:_ ~data:_ ~parent:_ name : span =
  Runtime_events.User.write Events.span_enter_event name;
  Span_runtime_events { name }

let exit_span (_self : st) sp =
  match sp with
  | Span_runtime_events info ->
    Runtime_events.User.write Events.span_exit_event info.name
  | _ -> ()

let add_data_to_span _st _sp _data =
  (* Runtime_events doesn't support adding data to spans after creation,
     so we just ignore this *)
  ()

let message (_self : st) ~level:_ ~params:_ ~data:_ ~span:_ msg : unit =
  Runtime_events.User.write Events.message_event msg

let metric (_self : st) ~level:_ ~params:_ ~data:_ name m : unit =
  match m with
  | Core_ext.Metric_int n ->
    Runtime_events.User.write Events.metric_int_event (name, n)
  | Core_ext.Metric_float f ->
    Runtime_events.User.write Events.metric_float_event (name, f)
  | _ -> ()

let extension _self ~level:_ _ev =
  (* Extension events like set_thread_name, set_process_name could be
     emitted as custom events if needed *)
  ()

(* Create collector *)
let callbacks : st Collector.Callbacks.t =
  Collector.Callbacks.make ~init ~shutdown ~enabled ~enter_span ~exit_span
    ~add_data_to_span ~message ~metric ~extension ()

let collector ?(start_events = true) () : Collector.t =
  let st = create ~start_events () in
  Collector.C_some (st, callbacks)

(* Setup function *)
let setup ?(start_events = true) () =
  Trace_core.setup_collector (collector ~start_events ())

(* Convenience wrapper *)
let with_setup ?start_events f =
  setup ?start_events ();
  Fun.protect ~finally:Trace_core.shutdown f
