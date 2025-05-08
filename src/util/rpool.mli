(** A resource pool (for buffers) *)

type 'a t

val create :
  max_size:int -> create:(unit -> 'a) -> clear:('a -> unit) -> unit -> 'a t

val alloc : 'a t -> 'a
val recycle : 'a t -> 'a -> unit
val with_ : 'a t -> ('a -> 'b) -> 'b
