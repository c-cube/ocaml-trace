(** Trace. *)

include module type of Types
module Collector = Collector

(** {2 Tracing} *)

val enabled : unit -> bool
(** Is there a collector?
  
    This is fast, so that the traced program can check it before creating
    any span or message *)

val enter_span :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  span
(** Enter a span. A span is a delimited period of time with
    a start instant ("enter") and stop instant ("exit"), associated
    with some metadata about the code entering/exiting some piece of code.

    In particular the entrypoint comes with the location of the code
    (you can use [__FILE__] and [__LINE__] directly in OCaml),
    a mandatory name, and some optional metadata in a JSON-like representation.
*)

val exit_span : span -> unit
(** Exit the span.

    This should be called exactly once per span (even in case of exception).
    Once this is called, a timestamp might be recorded,
  and the span is considered finished and can't be used anymore *)

val with_span :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  (span -> 'a) ->
  'a
(** [with_span ~__FILE__ ~__LINE__ name f] enters a new span [sp],
    and calls [f sp].
    [sp] might be a dummy span if no collector is installed.
    When [f sp] returns or raises, the span [sp] is exited.

    This is the recommended way to instrument most code. *)

val message :
  ?span:span -> ?data:(unit -> (string * user_data) list) -> string -> unit
(** [message msg] logs a message [msg] (if a collector is installed).
    Additional metadata can be provided.
    @param span the surrounding span, if any. This might be ignored by the collector. *)

val messagef :
  ?span:span ->
  ?data:(unit -> (string * user_data) list) ->
  ((('a, Format.formatter, unit, unit) format4 -> 'a) -> unit) ->
  unit
(** [messagef (fun k->k"hello %s %d!" "world" 42)] is like
    [message "hello world 42!"] but only computes the string formatting
    if a collector is installed. *)

val set_thread_name : string -> unit
(** Give a name to the current thread.
    This might be used by the collector
    to display traces in a more informative way. *)

val set_process_name : string -> unit
(** Give a name to the current process.
    This might be used by the collector
    to display traces in a more informative way. *)

val counter_int : string -> int -> unit
(** Emit a counter of type [int]. Counters represent the evolution of some quantity
    over time. *)

val counter_float : string -> float -> unit
(** Emit a counter of type [float]. See {!counter_int} for more details. *)

(** {2 Collector} *)

type collector = (module Collector.S)
(** An event collector.

    See {!Collector} for more details. *)

val setup_collector : collector -> unit
(** [setup_collector c] installs [c] as the current collector.
    @raise Invalid_argument if there already is an established
    collector. *)

val shutdown : unit -> unit
(** [shutdown ()] shutdowns the current collector, if one was installed,
    and waits for it to terminate before returning. *)

(**/**)

(* no guarantee of stability *)
module Internal_ : sig
  module Atomic_ = Atomic_
end

(**/**)
