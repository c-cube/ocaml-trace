(** Basic Blocking Queue *)

type 'a t

val create : unit -> _ t

exception Closed

val push : 'a t -> 'a -> unit
(** [push q x] pushes [x] into [q], and returns [()].
    @raise Closed if [close q] was previously called.*)

val pop_all : 'a t -> 'a list
(** [pop_all bq] returns all items presently in [bq], in the same order, and
    clears [bq]. It blocks if no element is in [bq]. *)

val close : _ t -> unit
(** Close the queue, meaning there won't be any more [push] allowed. *)
