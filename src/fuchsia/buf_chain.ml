(** A set of buffers in use, and a set of ready buffers *)

open Common_

(** Buffers in use *)
type buffers =
  | B_one of { mutable buf: Buf.t }
  | B_many of Buf.t Lock.t array
      (** mask(thread id) -> buffer. This reduces contention *)

type t = {
  bufs: buffers;
  has_ready: bool A.t;
  ready: Buf.t Queue.t Lock.t;
      (** Buffers that are full (enough) and must be written *)
  buf_pool: Buf_pool.t;
}
(** A set of buffers, some of which are ready to be written *)

open struct
  let shard_log = 4
  let shard = 1 lsl shard_log
  let shard_mask = shard - 1
end

let create ~(sharded : bool) ~(buf_pool : Buf_pool.t) () : t =
  let bufs =
    if sharded then (
      let bufs =
        Array.init shard (fun _ -> Lock.create @@ Buf_pool.alloc buf_pool)
      in
      B_many bufs
    ) else
      B_one { buf = Buf_pool.alloc buf_pool }
  in
  {
    bufs;
    buf_pool;
    has_ready = A.make false;
    ready = Lock.create @@ Queue.create ();
  }

open struct
  let put_in_ready (self : t) buf : unit =
    if Buf.size buf > 0 then (
      let@ q = Lock.with_ self.ready in
      Atomic.set self.has_ready true;
      Queue.push buf q
    )

  let assert_available buf ~available =
    if Buf.available buf < available then (
      let msg =
        Printf.sprintf
          "fuchsia: buffer is too small (available: %d bytes, needed: %d bytes)"
          (Buf.available buf) available
      in
      failwith msg
    )
end

(** Move all non-empty buffers to [ready] *)
let ready_all_non_empty (self : t) : unit =
  let@ q = Lock.with_ self.ready in
  match self.bufs with
  | B_one r ->
    if not (Buf.is_empty r.buf) then (
      Queue.push r.buf q;
      A.set self.has_ready true;
      r.buf <- Buf.empty
    )
  | B_many bufs ->
    Array.iter
      (fun buf ->
        Lock.update buf (fun buf ->
            if Buf.size buf > 0 then (
              Queue.push buf q;
              A.set self.has_ready true;
              Buf.empty
            ) else
              buf))
      bufs

let[@inline] has_ready self : bool = A.get self.has_ready

(** Get access to ready buffers, then clean them up automatically *)
let pop_ready (self : t) ~(f : Buf.t Queue.t -> 'a) : 'a =
  let@ q = Lock.with_ self.ready in
  let res = f q in

  (* clear queue *)
  Queue.iter (Buf_pool.recycle self.buf_pool) q;
  Queue.clear q;
  A.set self.has_ready false;
  res

(** Maximum size available, in words, for a single message *)
let[@inline] max_size_word (_self : t) : int = fuchsia_buf_size lsr 3

(** Obtain a buffer with at least [available_word] 64-bit words *)
let with_buf (self : t) ~(available_word : int) (f : Buf.t -> 'a) : 'a =
  let available = available_word lsl 3 in
  match self.bufs with
  | B_one r ->
    if Buf.available r.buf < available_word then (
      put_in_ready self r.buf;
      r.buf <- Buf_pool.alloc self.buf_pool
    );
    assert_available r.buf ~available;
    f r.buf
  | B_many bufs ->
    let tid = Thread.(id (self ())) in
    let masked_tid = tid land shard_mask in
    let buf_lock = bufs.(masked_tid) in
    let@ buf = Lock.with_ buf_lock in
    let buf =
      if Buf.available buf < available then (
        put_in_ready self buf;
        let new_buf = Buf_pool.alloc self.buf_pool in
        assert_available new_buf ~available;
        Lock.set_while_locked buf_lock new_buf;
        new_buf
      ) else
        buf
    in
    f buf

(** Dispose of resources (here, recycle buffers) *)
let dispose (self : t) : unit =
  match self.bufs with
  | B_one r ->
    Buf_pool.recycle self.buf_pool r.buf;
    r.buf <- Buf.empty
  | B_many bufs ->
    Array.iter
      (fun buf_lock ->
        let@ buf = Lock.with_ buf_lock in
        Buf_pool.recycle self.buf_pool buf;
        Lock.set_while_locked buf_lock Buf.empty)
      bufs
