module A = Trace_core.Internal_.Atomic_
module FWrite = Trace_fuchsia_write
module B_queue = Trace_private_util.B_queue
module Buf = FWrite.Buf
module Buf_pool = FWrite.Buf_pool
module Output = FWrite.Output

let on_tracing_error =
  ref (fun s -> Printf.eprintf "trace-fuchsia error: %s\n%!" s)

let ( let@ ) = ( @@ )
let spf = Printf.sprintf
