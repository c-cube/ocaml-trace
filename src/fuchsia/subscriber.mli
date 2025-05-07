type t
(** Main subscriber state. *)

val create : ?buf_pool:Buf_pool.t -> pid:int -> exporter:Exporter.t -> unit -> t
(** Create a subscriber state. *)

val flush : t -> unit
val close : t -> unit
val active : t -> bool

module Callbacks : Trace_subscriber.Callbacks.S with type st = t

val subscriber : t -> Trace_subscriber.t
(** Subscriber that writes json into this writer *)

(**/**)

val on_tracing_error : (string -> unit) ref

(**/**)
