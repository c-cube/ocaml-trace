(** Generic subscribers.

    This defines the notion of a {b subscriber},
    a set of callbacks for every trace event.
    It also defines a collector that needs to be installed
    for the subscriber(s) to be called.

    @since NEXT_RELEASE
*)

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

(** {2 Global set of subscribers}

    There is a global set of subscribers (it is not mandatory to use it).
    When the first subscriber is added to it, a {!Trace_core.collector}
    is registered (see {!Trace_core.setup_collector}).

    When the last subscriber is unregistered, the collector is shut down. *)

module Handle : sig
  type t = private int
  (** A unique handle for a subscriber *)
end

val register_subscriber : t -> Handle.t
(** Register a subscriber. This calls {!Trace_core.setup_collector} if
  no other subscriber is registered.
  @raise Invalid_argument if {!Trace_core.setup_collector} fails. *)

val unregister_subscriber : Handle.t -> unit
(** Remove a subscriber using its handle. If no subscriber remains,
  {!Trace_core.shutdown} is called to remove the collector. *)

(**/**)

module Private_ : sig
  val get_now_ns_ : (unit -> float) option ref
  (** The callback used to get the current timestamp *)

  val get_tid_ : (unit -> int) option ref
  (** The callback used to get the current thread's id *)

  val now_ns : unit -> float
end

(**/**)
