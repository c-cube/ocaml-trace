(** Trace. *)

include module type of Types
module Collector = Collector
module Meta_map = Meta_map

(** {2 Tracing} *)

val enabled : unit -> bool
(** Is there a collector?

    This is fast, so that the traced program can check it before creating
    any span or message. *)

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

    This is the recommended way to instrument most code.

    {b NOTE} an important restriction is that this is only supposed to
    work for synchronous, direct style code. Monadic concurrency, Effect-based
    fibers, etc. might not play well with this style of spans on some
    or all backends. If you use cooperative concurrency,
    see {!enter_manual_span}.
*)

val add_data_to_span : span -> (string * user_data) list -> unit
(** Add structured data to the given active span (see {!with_span}).
    Behavior is not specified if the span has been exited.
    @since 0.4 *)

val enter_manual_sub_span :
  parent:explicit_span ->
  ?flavor:[ `Sync | `Async ] ->
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  explicit_span
(** Like {!with_span} but the caller is responsible for
    obtaining the [parent] span from their {e own} caller, and carry the resulting
    {!explicit_span} to  the matching {!exit_manual_span}. 
    @param flavor a description of the span that can be used by the {!Collector.S}
      to decide how to represent the span. Typically, [`Sync] spans
      start and stop on one thread, and are nested purely by their timestamp;
      and [`Async] spans can overlap, migrate between threads, etc. (as happens in
      Lwt, Eio, Async, etc.) which impacts how the collector might represent them.
    @since 0.3 *)

val enter_manual_toplevel_span :
  ?flavor:[ `Sync | `Async ] ->
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  explicit_span
(** Like {!with_span} but the caller is responsible for carrying this
    [explicit_span] around until it's exited with {!exit_manual_span}.
    The span can be used as a parent in {!enter_manual_sub_span}.
    @param flavor see {!enter_manual_sub_span} for more details.
    @since 0.3 *)

val exit_manual_span : explicit_span -> unit
(** Exit an explicit span. This can be on another thread, in a
    fiber or lightweight thread, etc. and will be supported by backends
    nonetheless.
    The span can be obtained via {!enter_manual_sub_span} or
    {!enter_manual_toplevel_span}.
    @since 0.3 *)

val add_data_to_manual_span : explicit_span -> (string * user_data) list -> unit
(** [add_data_explicit esp data] adds [data] to the span [esp].
      The behavior is not specified is the span has been exited already.
    @since 0.4 *)

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

val counter_int :
  ?data:(unit -> (string * user_data) list) -> string -> int -> unit
(** Emit a counter of type [int]. Counters represent the evolution of some quantity
    over time.
    @param data metadata for this metric (since 0.4) *)

val counter_float :
  ?data:(unit -> (string * user_data) list) -> string -> float -> unit
(** Emit a counter of type [float]. See {!counter_int} for more details.
    @param data metadata for this metric (since 0.4) *)

val enter_context : string -> unit
(** [enter_context name] enters a local context with the
    given name. The name must be a static string.

    The exact semantic of contexts depends on your collector:
      for TEF it might actually use contexts, for Tracy it
      might use traces, for OTEL it might be ignored, etc.

    @since NEXT_RELEASE *)

val exit_context : string -> unit
(** Exit a context. This must come after the corresponding
    {!enter_context}, ideally on the same thread.
    @since NEXT_RELEASE *)

val with_context : string -> (unit -> 'a) -> 'a
(** [with_context name f] enters the context, calls [f()],
    and exits the context.
    @since NEXT_RELEASE *)

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
