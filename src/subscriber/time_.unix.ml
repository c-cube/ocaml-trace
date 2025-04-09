let[@inline] get_time_ns () : float =
  let t = Unix.gettimeofday () in
  t *. 1e9
