open Common_
open Types
open Trace_core

module Buf_pool = struct
  type t = Buffer.t Trace_util.Rpool.t

  let create ?(max_size = 32) ?(buf_size = 256) () : t =
    Trace_util.Rpool.create ~max_size ~clear:Buffer.reset
      ~create:(fun () -> Buffer.create buf_size)
      ()
end

open struct
  let[@inline] time_us_of_time_ns (t : int64) : float =
    Int64.div t 1_000L |> Int64.to_float
end

type t = {
  active: bool A.t;
  pid: int;
  buf_pool: Buf_pool.t;
  exporter: Exporter.t;
  trace_id_gen: Trace_util.Trace_id64.Gen.t;
}
(** Subscriber state *)

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
    trace_id_gen = Trace_util.Trace_id64.Gen.create ();
  }

open struct
  type st = t

  let rec flavor_of_params = function
    | [] -> `Sync
    | Core_ext.Extension_span_flavor f :: _ -> f
    | _ :: tl -> flavor_of_params tl

  let new_trace_id (self : st) = Trace_util.Trace_id64.Gen.gen self.trace_id_gen
  let init _ = ()
  let shutdown (self : st) = close self

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", `String f) :: data

  let enter_span (self : st) ~__FUNCTION__ ~__FILE__ ~__LINE__ ~level:_ ~params
      ~data ~parent name : span =
    let start_us = time_us_of_time_ns @@ Trace_util.Mock_.now_ns () in
    let flavor = flavor_of_params params in

    let pid = self.pid in
    let tid = Trace_util.Mock_.get_tid () in
    match flavor with
    | `Sync -> Span_tef_sync { name; pid; tid; args = data; start_us }
    | `Async ->
      let trace_id =
        match parent with
        | P_some (Span_tef_async sp) -> sp.trace_id
        | _ -> new_trace_id self
      in
      let data = add_fun_name_ __FUNCTION__ data in

      (let@ buf = Trace_util.Rpool.with_ self.buf_pool in
       Writer.emit_begin_async buf ~name ~pid ~tid ~trace_id ~ts:start_us
         ~args:data;
       self.exporter.on_json buf);

      Span_tef_async { pid; tid; trace_id; name; args = data }

  let exit_span (self : st) sp =
    let end_time_us = time_us_of_time_ns @@ Trace_util.Mock_.now_ns () in

    let@ buf = Trace_util.Rpool.with_ self.buf_pool in
    let did_write =
      match sp with
      | Span_tef_sync { name; pid; tid; args; start_us } ->
        (* emit full event *)
        Writer.emit_duration_event buf ~pid ~tid ~name ~start:start_us
          ~end_:end_time_us ~args;
        true
      | Span_tef_async { name; trace_id; pid; tid; args } ->
        Writer.emit_end_async buf ~pid ~tid ~name ~trace_id ~ts:end_time_us
          ~args;
        true
      | _ -> false
    in

    if did_write then self.exporter.on_json buf

  let message (self : st) ~level:_ ~params:_ ~data ~span:_ msg : unit =
    let tid = Trace_util.Mock_.get_tid () in
    let time_us = time_us_of_time_ns @@ Trace_util.Mock_.now_ns () in
    let@ buf = Trace_util.Rpool.with_ self.buf_pool in
    Writer.emit_instant_event buf ~pid:self.pid ~tid ~name:msg ~ts:time_us
      ~args:data;
    self.exporter.on_json buf

  let counter_float (self : st) ~params:_ ~data:_ name n : unit =
    let tid = Trace_util.Mock_.get_tid () in
    let time_us = time_us_of_time_ns @@ Trace_util.Mock_.now_ns () in
    let@ buf = Trace_util.Rpool.with_ self.buf_pool in
    Writer.emit_counter buf ~pid:self.pid ~name ~tid ~ts:time_us n;
    self.exporter.on_json buf

  let metric (self : st) ~level:_ ~params ~data name m : unit =
    match m with
    | Core_ext.Metric_float n -> counter_float self ~params ~data name n
    | Core_ext.Metric_int i ->
      counter_float self ~params ~data name (float_of_int i)
    | _ -> ()

  let add_data_to_span _st sp data =
    match sp with
    | Span_tef_sync sp -> sp.args <- List.rev_append data sp.args
    | Span_tef_async sp -> sp.args <- List.rev_append data sp.args
    | _ -> ()

  let on_name_thread_ (self : st) ~tid name : unit =
    let@ buf = Trace_util.Rpool.with_ self.buf_pool in
    Writer.emit_name_thread buf ~pid:self.pid ~tid ~name;
    self.exporter.on_json buf

  let on_name_process_ (self : st) name : unit =
    let@ buf = Trace_util.Rpool.with_ self.buf_pool in
    Writer.emit_name_process ~pid:self.pid ~name buf;
    self.exporter.on_json buf

  let extension (self : st) ~level:_ ev =
    match ev with
    | Core_ext.Extension_set_thread_name name ->
      let tid = Trace_util.Mock_.get_tid () in
      on_name_thread_ self ~tid name
    | Core_ext.Extension_set_process_name name -> on_name_process_ self name
    | _ -> ()
end

let callbacks_collector : _ Collector.Callbacks.t =
  Collector.Callbacks.make ~init ~shutdown ~enter_span ~exit_span ~message
    ~add_data_to_span ~metric ~extension ()

let collector (self : t) : Collector.t =
  Collector.C_some (self, callbacks_collector)
