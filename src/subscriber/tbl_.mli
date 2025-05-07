type 'v t

val create : unit -> 'v t
val add : 'v t -> int64 -> 'v -> unit
val find_exn : 'v t -> int64 -> 'v
val remove : _ t -> int64 -> unit
val to_list : 'v t -> (int64 * 'v) list
