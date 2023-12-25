module Mock_ = struct
  let enabled = ref false
  let now = ref 0

  let[@inline never] now_us () : int64 =
    let x = !now in
    incr now;
    Int64.of_int x
end

let counter = Mtime_clock.counter ()

(** Now, in nanoseconds *)
let[@inline] now_ns () : int64 =
  if !Mock_.enabled then
    Mock_.now_us ()
  else (
    let t = Mtime_clock.count counter in
    Mtime.Span.to_uint64_ns t
  )
