(** Generic subscribers.

    This defines the notion of a {b subscriber}, a set of callbacks for every
    trace event. It also defines a collector that needs to be installed for the
    subscriber(s) to be called.

    Thanks to {!Subscriber.tee_l} it's possible to combine multiple subscribers
    into a single collector.

    @since 0.8 *)

module Callbacks = Callbacks
module Subscriber = Subscriber
module Span_sub = Span_sub

(** {2 Main API} *)

type t = Subscriber.t
(** A trace subscriber. It pairs a set of callbacks with the state they need
    (which can contain a file handle, a socket to write events to, config,
    etc.).

    The design goal for this is that it should be possible to avoid allocations
    whenever the trace collector invokes the callbacks. *)

val collector : t -> Trace_core.collector
(** A collector that calls the subscriber's callbacks. It uses [mtime] (if
    available) to obtain timestamps. *)

(** A counter-based span generator.
    @since NEXT_RELEASE *)
module Span_id_generator : sig
  type t

  val create : unit -> t
  val gen : t -> Span_sub.span_id
end

(** A counter-based generator.
    @since NEXT_RELEASE *)
module Trace_id_generator : sig
  type t

  val create : unit -> t
  val gen : t -> Span_sub.trace_id
end

(**/**)

module Private_ : sig
  val mock : bool ref
  (** Global mock flag. If enable, all timestamps, tid, etc should be faked. *)

  val get_now_ns_ : (unit -> int64) ref
  (** The callback used to get the current timestamp *)

  val get_tid_ : (unit -> int) ref
  (** The callback used to get the current thread's id *)

  val now_ns : unit -> int64
  (** Get the current timestamp, or a mock version *)
end

(**/**)
