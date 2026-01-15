(** Callbacks used for subscribers.

    Each subscriber defines a set of callbacks, for each possible tracing event.
    These callbacks take a custom state that is paired with the callbacks in
    {!Subscriber.t}.

    To use a default implementation for some callbacks, use:

    {[
      module My_callbacks = struct
        type st = …

        include Trace_subscriber.Callbacks.Dummy

        let on_init (state:st) ~time_ns : unit = …

        (* … other custom callbacks … *)
      end
    ]}

    {b NOTE}: the [trace_id] passed alongside manual spans is guaranteed to be
    at least 64 bits. *)

open Trace_core

type 'st t = {
  on_init: 'st -> time_ns:int64 -> unit;
      (** Called when the subscriber is initialized in a collector *)
  new_span_id: 'st -> Span_sub.span_id;
      (** How to generate a new span ID?
          @since NEXT_RELEASE *)
  new_trace_id: 'st -> Span_sub.trace_id;
      (** How to generate a new trace ID?
          @since NEXT_RELEASE *)
  on_shutdown: 'st -> time_ns:int64 -> unit;
      (** Called when the collector is shutdown *)
  on_enter_span: 'st -> Span_sub.t -> unit;  (** Enter a span *)
  on_exit_span: 'st -> time_ns:int64 -> tid:int -> Span_sub.t -> unit;
      (** Exit a span. This and [on_enter_span] must follow strict stack
          discipline.
          @param tid the id of the thread on which the span was exited. *)
  on_message:
    'st ->
    time_ns:int64 ->
    tid:int ->
    span:Span_sub.t option ->
    params:extension_parameter list ->
    data:(string * Trace_core.user_data) list ->
    string ->
    unit;
      (** Emit a log message *)
  on_counter:
    'st ->
    time_ns:int64 ->
    tid:int ->
    params:extension_parameter list ->
    data:(string * Trace_core.user_data) list ->
    name:string ->
    float ->
    unit;
      (** Emit the current value of a counter *)
  on_extension_event: 'st -> time_ns:int64 -> tid:int -> extension_event -> unit;
      (** Extension event
          @since 0.8 *)
}
(** Callbacks for a subscriber. There is one callback per event in {!Trace}. The
    type ['st] is the state that is passed to every single callback. *)

(** Dummy callbacks. It can be useful to reuse some of these functions in a real
    subscriber that doesn't want to handle {b all} events, but only some of
    them.

    To write a subscriber that only supports some callbacks, this can be handy:
    {[
      module My_callbacks = struct
      type st = my_own_state
      include Callbacks.Dummy
      let on_counter (st:st) ~time_ns ~tid ~data ~name v : unit = ...
      end
    ]} *)
module Dummy = struct
  let on_init _ ~time_ns:_ = ()
  let new_span_id _ = Int64.min_int
  let new_trace_id _ = -1L
  let on_shutdown _ ~time_ns:_ = ()
  let on_message _ ~time_ns:_ ~tid:_ ~span:_ ~params:_ ~data:_ _msg = ()
  let on_counter _ ~time_ns:_ ~tid:_ ~params:_ ~data:_ ~name:_ _v = ()
  let on_enter_span _ _sp = ()
  let on_exit_span _ ~time_ns:_ ~tid:_ _ = ()
  let on_extension_event _ ~time_ns:_ ~tid:_ _ = ()
end

(** Build a set of callbacks.
    @since NEXT_RELEASE *)
let make ~new_span_id ?(new_trace_id = Dummy.new_trace_id)
    ?(on_init = Dummy.on_init) ?(on_enter_span = Dummy.on_enter_span)
    ?(on_exit_span = Dummy.on_exit_span) ?(on_message = Dummy.on_message)
    ?(on_counter = Dummy.on_counter)
    ?(on_extension_event = Dummy.on_extension_event)
    ?(on_shutdown = Dummy.on_shutdown) () : _ t =
  {
    on_init;
    new_span_id;
    new_trace_id;
    on_enter_span;
    on_exit_span;
    on_message;
    on_counter;
    on_extension_event;
    on_shutdown;
  }

(** Dummy callbacks, ignores all events. *)
let dummy () : _ t = make ~new_span_id:(fun () -> Span_sub.dummy_span_id) ()
