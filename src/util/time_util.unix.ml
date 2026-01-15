let[@inline] get_time_ns () : int64 =
  let t = Unix.gettimeofday () in
  Int64.of_float (t *. 1e9)
