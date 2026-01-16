open Trace_core
open Common_

module Buf_pool : sig
  type t

  val create : ?max_size:int -> ?buf_size:int -> unit -> t
end

type t
(** Main state. *)

val create : ?buf_pool:Buf_pool.t -> pid:int -> exporter:Exporter.t -> unit -> t
(** Create a fresh state. *)

val flush : t -> unit
val close : t -> unit
val active : t -> bool

val callbacks_collector : t Collector.Callbacks.t
(** Callbacks used for the subscriber *)

val collector : t -> Collector.t
(** Subscriber that writes json into this writer *)

(**/**)

val on_tracing_error : (string -> unit) ref

(**/**)
