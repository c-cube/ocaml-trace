type t = {
  mutable buf: Buf.t;
  mutable send_buf: Buf.t -> unit;
  buf_pool: Buf_pool.t;
}

let create ~(buf_pool : Buf_pool.t) ~send_buf () : t =
  let buf_size = buf_pool.buf_size in
  let buf = Buf.create buf_size in
  { buf; send_buf; buf_pool }

open struct
  (* NOTE: there is a potential race condition if an output is
     flushed from the main thread upon closing, while
     the local thread is blissfully writing new records to it
     as we're winding down the collector. This is trying to reduce
     the likelyhood of a race happening. *)
  let[@poll error] replace_buf_ (self : t) (new_buf : Buf.t) : Buf.t =
    let old_buf = self.buf in
    self.buf <- new_buf;
    old_buf

  let flush_ (self : t) : unit =
    let new_buf = Buf_pool.alloc self.buf_pool in
    let old_buf = replace_buf_ self new_buf in
    self.send_buf old_buf

  let[@inline never] cycle_buf (self : t) ~available : Buf.t =
    flush_ self;
    let buf = self.buf in

    if Buf.available buf < available then (
      let msg =
        Printf.sprintf
          "fuchsia: buffer is too small (available: %d bytes, needed: %d bytes)"
          (Buf.available buf) available
      in
      failwith msg
    );
    buf
end

let[@inline] flush (self : t) : unit = if Buf.size self.buf > 0 then flush_ self

(** Maximum size available, in words, for a single message *)
let[@inline] max_size_word (self : t) : int = self.buf_pool.buf_size lsr 3

(** Obtain a buffer with at least [available] bytes *)
let[@inline] get_buf (self : t) ~(available_word : int) : Buf.t =
  let available = available_word lsl 3 in
  if Buf.available self.buf >= available then
    self.buf
  else
    cycle_buf self ~available

let into_buffer ~buf_pool (buffer : Buffer.t) : t =
  let send_buf (buf : Buf.t) =
    Buffer.add_subbytes buffer buf.buf 0 buf.offset
  in
  create ~buf_pool ~send_buf ()

let dispose (self : t) : unit =
  flush_ self;
  Buf_pool.recycle self.buf_pool self.buf;
  self.buf <- Buf.empty
