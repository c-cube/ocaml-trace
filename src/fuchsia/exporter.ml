(** An exporter, takes buffers with fuchsia events, and writes them somewhere *)

open Common_

type t = {
  write_bufs: Buf.t Queue.t -> unit;
      (** Takes buffers and writes them somewhere. The buffers are only valid
          during this call and must not be stored. The queue must not be
          modified. *)
  flush: unit -> unit;  (** Force write *)
  close: unit -> unit;  (** Close underlying resources *)
}
(** An exporter, takes buffers and writes them somewhere. This should be
    thread-safe if used in a threaded environment. *)

open struct
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
end

(** Export to the channel
    @param close_channel if true, closing the exporter will close the channel *)
let of_out_channel ~close_channel oc : t =
  let lock = Mutex.create () in
  let closed = ref false in
  let flush () =
    let@ () = with_lock lock in
    flush oc
  in
  let close () =
    let@ () = with_lock lock in
    if not !closed then (
      closed := true;
      if close_channel then close_out_noerr oc
    )
  in
  let write_bufs bufs =
    if not (Queue.is_empty bufs) then
      let@ () = with_lock lock in
      Queue.iter (fun (buf : Buf.t) -> output oc buf.buf 0 buf.offset) bufs
  in
  { flush; close; write_bufs }

let of_buffer (buffer : Buffer.t) : t =
  let buffer = Lock.create buffer in
  let write_bufs bufs =
    if not (Queue.is_empty bufs) then
      let@ buffer = Lock.with_ buffer in
      Queue.iter
        (fun (buf : Buf.t) -> Buffer.add_subbytes buffer buf.buf 0 buf.offset)
        bufs
  in
  { flush = ignore; close = ignore; write_bufs }
