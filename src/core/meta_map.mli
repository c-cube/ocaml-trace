(** Associative containers with Heterogeneous Values *)

(** Keys with a type witness. *)
module Key : sig
  type 'a t
  (** A key of type ['a t] is used to access the portion of the
      map or table that associates keys of type ['a] to values. *)

  val create : unit -> 'a t
  (** Make a new key. This is generative, so calling [create ()] twice with the
      same return type will produce incompatible keys that cannot see each
      other's bindings. *)

  val equal : 'a t -> 'a t -> bool
  (** Compare two keys that have compatible types. *)
end

type pair = Pair : 'a Key.t * 'a -> pair

type t
(** Immutable map from {!Key.t} to values *)

val empty : t
val mem : _ Key.t -> t -> bool
val add : 'a Key.t -> 'a -> t -> t
val remove : _ Key.t -> t -> t
val length : t -> int
val cardinal : t -> int
val find : 'a Key.t -> t -> 'a option

val find_exn : 'a Key.t -> t -> 'a
(** @raise Not_found if the key is not in the table. *)

val iter : (pair -> unit) -> t -> unit
val add_list : t -> pair list -> t
val of_list : pair list -> t
val to_list : t -> pair list
