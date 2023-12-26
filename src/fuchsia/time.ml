let counter = Mtime_clock.counter ()

(** Now, in nanoseconds *)
let[@inline] now_ns () : int64 =
  let t = Mtime_clock.count counter in
  Mtime.Span.to_uint64_ns t
