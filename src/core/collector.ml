(** A global collector.

    The collector, if present, is responsible for collecting messages and spans,
    and storing them, recording them, forward them, or offering them to other
    services and processes. *)

open Types

type span += Span_dummy

(** A fake span that never emits data. All collectors should handle this span by
    doing nothing. *)
let dummy_span : span = Span_dummy

module Callbacks = struct
  type 'st t = {
    enter_span:
      'st ->
      __FUNCTION__:string option ->
      __FILE__:string ->
      __LINE__:int ->
      params:extension_parameter list ->
      data:(string * user_data) list ->
      parent:parent ->
      string ->
      span;
        (** Enter a span *)
    exit_span: 'st -> span -> unit;
        (** Exit a span. Must be called exactly once per span. Additional
            constraints on nesting, threads, etc. vary per collector. *)
    current_span: 'st -> span option;
        (** Access the current span, if supported. Returns [None] if there is no
            current span or if the current span isn't tracked by the collector.
        *)
    add_data_to_span: 'st -> span -> (string * user_data) list -> unit;
    message:
      'st ->
      params:extension_parameter list ->
      data:(string * user_data) list ->
      span:span option ->
      string ->
      unit;
        (** Emit a message or log *)
    counter_int:
      'st ->
      params:extension_parameter list ->
      data:(string * user_data) list ->
      string ->
      int ->
      unit;
        (** Integer counter. *)
    counter_float:
      'st ->
      params:extension_parameter list ->
      data:(string * user_data) list ->
      string ->
      float ->
      unit;
    extension: 'st -> extension_event -> unit;
        (** Collector-specific extension *)
    shutdown: 'st -> unit;
        (** Shutdown collector, possibly waiting for it to finish sending data.
        *)
  }
  (** Callbacks taking a state ['st] *)

  (** Helper to create backends in a future-proof way *)
  let make ~enter_span ~exit_span ?(current_span = fun _ -> None)
      ~add_data_to_span ~message ~counter_int ~counter_float
      ?(extension = fun _ _ -> ()) ?(shutdown = ignore) () : _ t =
    {
      enter_span;
      exit_span;
      current_span;
      add_data_to_span;
      message;
      counter_int;
      counter_float;
      extension;
      shutdown;
    }
end

(** Definition of a collector.

    This is only relevant to implementors of tracing backends; to instrument
    your code you only need to look at the {!Trace} module.

    The definition changed since NEXT_RELEASE to a record of callbacks + a state
*)
type t =
  | C_none  (** No collector. *)
  | C_some : 'st * 'st Callbacks.t -> t
      (** Collector with a state and some callbacks. *)

let[@inline] is_some = function
  | C_none -> false
  | C_some _ -> true
