let[@inline] int64_of_trace_id_ (id : Trace_core.trace_id) : int64 =
  if id == Trace_core.Collector.dummy_trace_id then
    0L
  else
    Bytes.get_int64_le (Bytes.unsafe_of_string id) 0

module Mock_ = struct
  let enabled = ref false
  let now = ref 0

  (* used to mock timing *)
  let get_now_ns () : float =
    let x = !now in
    incr now;
    float_of_int x *. 1000.

  let get_tid_ () : int = 3
end
