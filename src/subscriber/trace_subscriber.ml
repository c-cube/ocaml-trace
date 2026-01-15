open Trace_core
module Callbacks = Callbacks
module Subscriber = Subscriber
module Span_sub = Span_sub

type t = Subscriber.t

module Private_ = struct
  let mock = ref false
  let get_now_ns_ = ref Time_.get_time_ns
  let get_tid_ = ref Thread_.get_tid

  (** Now, in nanoseconds *)
  let[@inline] now_ns () : int64 =
    if !mock then
      !get_now_ns_ ()
    else
      Time_.get_time_ns ()

  let[@inline] tid_ () : int =
    if !mock then
      !get_tid_ ()
    else
      Thread_.get_tid ()
end

open struct
  module A = Trace_core.Internal_.Atomic_
  open Private_

  type Trace_core.span += Span_sub of Span_sub.t

  let enter_span (Subscriber.Sub { st; callbacks = cb }) ~__FUNCTION__ ~__FILE__
      ~__LINE__ ~params ~data ~parent name : span =
    let id = cb.new_span_id st in
    let tid = tid_ () in
    let time_ns = now_ns () in

    let trace_id =
      match parent with
      | P_some (Span_sub span) -> span.trace_id
      | _ -> cb.new_trace_id st
    in

    let flavor = ref `Sync in
    List.iter
      (function
        | Core_ext.Extension_span_flavor f -> flavor := f
        | _ -> ())
      params;

    let span : Span_sub.t =
      {
        name;
        id;
        tid;
        __FUNCTION__;
        __FILE__;
        __LINE__;
        data;
        parent;
        trace_id;
        flavor = !flavor;
        params;
        time_ns;
        time_exit_ns = Int64.max_int;
      }
    in

    cb.on_enter_span st span;

    Span_sub span

  let exit_span (Subscriber.Sub { st; callbacks = cb }) span : unit =
    match span with
    | Span_sub span ->
      let time_ns = now_ns () in
      span.time_exit_ns <- time_ns;
      let tid = tid_ () in
      cb.on_exit_span st ~time_ns ~tid span
    | _ -> ()

  let add_data_to_span _sub span data =
    match span with
    | Span_sub span -> span.data <- List.rev_append data span.data
    | _ -> ()

  let message (Subscriber.Sub { st; callbacks = cb }) ~params ~data ~span msg :
      unit =
    let time_ns = now_ns () in
    let tid = tid_ () in
    let span =
      match span with
      | Some (Span_sub s) -> Some s
      | _ -> None
    in
    cb.on_message st ~time_ns ~tid ~span ~params ~data msg

  let counter_float (Subscriber.Sub { st; callbacks = cb }) ~params ~data name f
      : unit =
    let time_ns = now_ns () in
    let tid = tid_ () in
    cb.on_counter st ~tid ~time_ns ~params ~data ~name f

  let[@inline] counter_int sub ~params ~data name i =
    counter_float sub ~params ~data name (float_of_int i)

  let init (Subscriber.Sub { st; callbacks = cb }) =
    (* init code *)
    let time_ns = now_ns () in
    cb.on_init st ~time_ns

  let shutdown (Subscriber.Sub { st; callbacks = cb }) =
    let time_ns = now_ns () in
    cb.on_shutdown st ~time_ns

  let extension_event (Subscriber.Sub { st; callbacks = cb }) ev =
    let tid = tid_ () in
    let time_ns = now_ns () in
    cb.on_extension_event st ~time_ns ~tid ev

  (* TODO: do we want to track this? *)
  let current_span _ = None

  let coll_cbs : t Collector.Callbacks.t =
    Collector.Callbacks.make ~enter_span ~exit_span ~current_span ~message
      ~add_data_to_span ~counter_int ~counter_float ~extension:extension_event
      ~init ~shutdown ()
end

(** A collector that calls the callbacks of subscriber *)
let collector (self : Subscriber.t) : collector =
  Collector.C_some (self, coll_cbs)

module Span_id_generator = struct
  type t = int A.t

  let create () = A.make 0
  let[@inline] gen self = A.fetch_and_add self 1 |> Int64.of_int
end

module Trace_id_generator = struct
  type t = int A.t

  let create () = A.make 0
  let[@inline] gen self = A.fetch_and_add self 1 |> Int64.of_int
end
