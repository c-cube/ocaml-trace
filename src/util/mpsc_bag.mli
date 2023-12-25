(** A multi-producer, single-consumer bag *)

type 'a t

val create : unit -> 'a t

val add : 'a t -> 'a -> unit
(** [add q x] adds [x] in the bag. *)

val pop_all : 'a t -> 'a list option
(** Return all current items in the insertion order. *)
