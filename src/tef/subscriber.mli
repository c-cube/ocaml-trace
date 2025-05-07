open Common_

module Buf_pool : sig
  type t

  val create : ?max_size:int -> ?buf_size:int -> unit -> t
end

type t
(** Main subscriber state. *)

val create : ?buf_pool:Buf_pool.t -> pid:int -> exporter:Exporter.t -> unit -> t
(** Create a subscriber state. *)

val flush : t -> unit
val close : t -> unit
val active : t -> bool

module Callbacks : Sub.Callbacks.S with type st = t

val subscriber : t -> Sub.t
(** Subscriber that writes json into this writer *)

(**/**)

val on_tracing_error : (string -> unit) ref

(**/**)
