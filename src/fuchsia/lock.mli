type 'a t
(** A value protected by a mutex *)

val create : 'a -> 'a t
val with_ : 'a t -> ('a -> 'b) -> 'b
val update : 'a t -> ('a -> 'a) -> unit
val update_map : 'a t -> ('a -> 'a * 'b) -> 'b

val set_while_locked : 'a t -> 'a -> unit
(** Change the value while inside [with_] or similar. *)
