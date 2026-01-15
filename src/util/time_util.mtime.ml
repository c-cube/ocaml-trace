let[@inline] get_time_ns () : int64 =
  let t = Mtime_clock.now () in
  Mtime.to_uint64_ns t
