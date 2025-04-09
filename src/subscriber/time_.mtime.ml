let[@inline] get_time_ns () : float =
  let t = Mtime_clock.now () in
  Int64.to_float (Mtime.to_uint64_ns t)
