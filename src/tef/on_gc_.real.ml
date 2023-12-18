module Trace = Trace_core
module A = Trace.Internal_.Atomic_
module RE = Runtime_events

module I_tbl = Hashtbl.Make (struct
  type t = int

  let equal : t -> t -> bool = ( = )
  let hash = Hashtbl.hash
end)

type on_gc_major_handler = int64 -> int64 -> unit

let active = A.make true
let shutdown () = A.set active false

let run_poll ~(on_gc_major : on_gc_major_handler) () =
  let begin_ = I_tbl.create 16 in

  let runtime_begin ring_id ts ev =
    match ev with
    | RE.EV_MAJOR -> I_tbl.add begin_ ring_id (RE.Timestamp.to_int64 ts)
    | _ -> ()
  in

  let runtime_end ring_id ts_end ev =
    match ev with
    | RE.EV_MAJOR ->
      (match I_tbl.find_opt begin_ ring_id with
      | None -> () (* TODO: warn *)
      | Some ts_start ->
        I_tbl.remove begin_ ring_id;
        let ts = RE.Timestamp.to_int64 ts_end in
        on_gc_major ts_start ts)
    | _ -> ()
  in

  RE.start ();
  let cbs = RE.Callbacks.create ~runtime_begin ~runtime_end () in
  let cursor = RE.create_cursor None in

  while A.get active do
    let n = RE.read_poll cursor cbs None in

    (* sleep a bit if nothing happened *)
    if n = 0 then Thread.delay 0.000_100
  done;
  RE.pause ();
  ()

let is_real = true
