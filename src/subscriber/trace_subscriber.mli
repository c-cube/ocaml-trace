(** Generic subscribers.

    This defines the notion of a {b subscriber}, a set of callbacks for every
    trace event. It also defines a collector that needs to be installed for the
    subscriber(s) to be called.

    @since 0.8 *)

module Callbacks = Callbacks
module Subscriber = Subscriber

include module type of struct
  include Types
end

(** {2 Main API} *)

type t = Subscriber.t

val collector : t -> Trace_core.collector
(** A collector that calls the subscriber's callbacks.

    It uses [mtime] (if available) to obtain timestamps. *)

(**/**)

module Private_ : sig
  val get_now_ns_ : (unit -> float) option ref
  (** The callback used to get the current timestamp *)

  val get_tid_ : (unit -> int) option ref
  (** The callback used to get the current thread's id *)

  val now_ns : unit -> float
end

(**/**)
