open Trace_core

type t
(** Main subscriber state. *)

val create : ?buf_pool:Buf_pool.t -> pid:int -> exporter:Exporter.t -> unit -> t
(** Create a subscriber state. *)

val flush : t -> unit
val close : t -> unit
val active : t -> bool
val callbacks : t Collector.Callbacks.t

val collector : t -> Collector.t
(** Subscriber that writes json into this writer *)
