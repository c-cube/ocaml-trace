open Common_
open Trace_private_util

type t = Buf.t Rpool.t

let create ?(max_size = 64) () : t =
  Rpool.create ~max_size ~clear:Buf.clear
    ~create:(fun () -> Buf.create fuchsia_buf_size)
    ()

let alloc = Rpool.alloc
let[@inline] recycle self buf = if buf != Buf.empty then Rpool.recycle self buf

let with_ (self : t) f =
  let x = alloc self in
  try
    let res = f x in
    recycle self x;
    res
  with e ->
    let bt = Printexc.get_raw_backtrace () in
    recycle self x;
    Printexc.raise_with_backtrace e bt
