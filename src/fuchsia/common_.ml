module A = Trace_core.Internal_.Atomic_
module Sub = Trace_subscriber

let on_tracing_error =
  ref (fun s -> Printf.eprintf "trace-fuchsia error: %s\n%!" s)

let ( let@ ) = ( @@ )
let spf = Printf.sprintf

let with_lock lock f =
  Mutex.lock lock;
  try
    let res = f () in
    Mutex.unlock lock;
    res
  with e ->
    let bt = Printexc.get_raw_backtrace () in
    Mutex.unlock lock;
    Printexc.raise_with_backtrace e bt

(** Buffer size we use. *)
let fuchsia_buf_size = 1 lsl 16
