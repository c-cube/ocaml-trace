(** A multi-producer, single-consumer bag *)

type 'a t

val create : unit -> 'a t

val add : 'a t -> 'a -> unit
(** [add q x] adds [x] in the bag. *)

exception Empty

val pop_all : 'a t -> 'a list
(** Return all current items in an unspecified order.
    @raise Empty if empty *)
