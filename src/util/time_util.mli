val get_time_ns : unit -> int64
(** Get current time in nanoseconds. The beginning point is unspecified, and
    this is assumed to be best-effort monotonic. Ideally, use [mtime]. *)
