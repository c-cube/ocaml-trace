(** Lock-free thread-safe hash table mapping strings to values.

    Very simple, the goal is to minimize contention. This is append-only. *)

type 'a t

val create : unit -> 'a t

val find_or_add : 'a t -> string -> (unit -> 'a) -> 'a
(** Find the value for key, or add it using init function. Thread-safe. Returns
    the same value for same key across all threads. *)

val find_exn : 'a t -> string -> 'a
(** Find the value for key
    @raise Not_found if not present *)

val find : 'a t -> string -> 'a option
