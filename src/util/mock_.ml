(** Mocking for tests *)

module Inner = struct
  let mock = ref false
  let get_now_ns_ref = ref Time_util.get_time_ns
  let get_tid_ref = ref Thread_util.get_tid
  let get_pid_ref = ref Unix_util.get_pid

  (** used to mock timing *)
  let make_time_mock () : unit -> int64 =
    let time_ = ref 0 in

    let get_now_ns () : int64 =
      let x = !time_ in
      incr time_;
      Int64.(mul (of_int x) 1000L)
    in
    get_now_ns
end

(** Now, in nanoseconds. Uses {!get_now_ns_ref} *)
let[@inline] now_ns () : int64 =
  if !Inner.mock then
    !Inner.get_now_ns_ref ()
  else
    Time_util.get_time_ns ()

(** Current thread's ID. Uses {!get_tid_ref} *)
let[@inline] get_tid () : int =
  if !Inner.mock then
    !Inner.get_tid_ref ()
  else
    Thread_util.get_tid ()

let[@inline] get_pid () : int =
  if !Inner.mock then
    !Inner.get_pid_ref ()
  else
    Unix_util.get_pid ()

let mock_all () : unit =
  Inner.mock := true;
  (Inner.get_pid_ref := fun () -> 2);
  (Inner.get_tid_ref := fun () -> 3);
  Inner.get_now_ns_ref := Inner.make_time_mock ();
  ()
