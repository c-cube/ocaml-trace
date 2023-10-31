(** A multi-producer, single-consumer queue (from picos) *)

type !'a t

val create : unit -> 'a t
val enqueue : 'a t -> 'a -> unit

exception Empty

val dequeue : 'a t -> 'a
(** @raise Empty if empty *)

val dequeue_all : 'a t -> 'a list
(** @raise Empty if empty *)
