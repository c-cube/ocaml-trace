open struct
  module A = Atomic

  exception Got_buf of Buf.t
end

module List_with_len = struct
  type +'a t =
    | Nil
    | Cons of int * 'a * 'a t

  let empty : _ t = Nil

  let[@inline] len = function
    | Nil -> 0
    | Cons (i, _, _) -> i

  let[@inline] cons x self = Cons (len self + 1, x, self)
end

type t = {
  max_len: int;
  buf_size: int;
  bufs: Buf.t List_with_len.t A.t;
}

let create ?(max_len = 64) ?(buf_size = 1 lsl 16) () : t =
  let buf_size = min (1 lsl 22) (max buf_size (1 lsl 15)) in
  { max_len; buf_size; bufs = A.make List_with_len.empty }

let alloc (self : t) : Buf.t =
  try
    while
      match A.get self.bufs with
      | Nil -> false
      | Cons (_, buf, tl) as old ->
        if A.compare_and_set self.bufs old tl then
          raise (Got_buf buf)
        else
          false
    do
      ()
    done;
    Buf.create self.buf_size
  with Got_buf b -> b

let recycle (self : t) (buf : Buf.t) : unit =
  Buf.clear buf;
  try
    while
      match A.get self.bufs with
      | Cons (i, _, _) when i >= self.max_len -> raise Exit
      | old ->
        not (A.compare_and_set self.bufs old (List_with_len.cons buf old))
    do
      ()
    done
  with Exit -> () (* do not recycle *)
