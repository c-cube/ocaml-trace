open Common_

type t
(** Main subscriber state. *)

val create : unit -> t
(** Create a subscriber state. *)

val close : t -> unit
val active : t -> bool

module Callbacks : Sub.Callbacks.S with type st = t

val subscriber : t -> Sub.t
(** Subscriber that writes json into this writer *)

(**/**)

val on_tracing_error : (string -> unit) ref

(**/**)
