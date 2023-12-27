open Util

type t = {
  buf: bytes;
  mutable offset: int;
}

let empty : t = { buf = Bytes.empty; offset = 0 }

let create (n : int) : t =
  let buf = Bytes.create (round_to_word n) in
  { buf; offset = 0 }

let[@inline] clear self = self.offset <- 0
let[@inline] available self = Bytes.length self.buf - self.offset
let[@inline] size self = self.offset

(* see below: we assume little endian *)
let () = assert (not Sys.big_endian)

let[@inline] add_i64 (self : t) (i : int64) : unit =
  (* NOTE: we use LE, most systems are this way, even though fuchsia
     says we should use the system's native endianess *)
  Bytes.set_int64_le self.buf self.offset i;
  self.offset <- self.offset + 8

let[@inline] add_string (self : t) (s : string) : unit =
  let len = String.length s in
  let missing = missing_to_round len in

  (* bound check *)
  assert (len + missing + self.offset <= Bytes.length self.buf);
  Bytes.unsafe_blit_string s 0 self.buf self.offset len;
  self.offset <- self.offset + len;

  (* add 0-padding *)
  if missing != 0 then (
    Bytes.unsafe_fill self.buf self.offset missing '\x00';
    self.offset <- self.offset + missing
  )

let to_string (self : t) : string = Bytes.sub_string self.buf 0 self.offset
