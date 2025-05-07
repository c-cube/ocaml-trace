open struct
  module A = Trace_core.Internal_.Atomic_
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

type 'a t = {
  max_size: int;
  create: unit -> 'a;
  clear: 'a -> unit;
  cached: 'a List_with_len.t A.t;
}

let create ~max_size ~create ~clear () : _ t =
  { max_size; create; clear; cached = A.make List_with_len.empty }

let alloc (type a) (self : a t) : a =
  let module M = struct
    exception Found of a
  end in
  try
    while
      match A.get self.cached with
      | Nil -> false
      | Cons (_, x, tl) as old ->
        if A.compare_and_set self.cached old tl then
          raise_notrace (M.Found x)
        else
          true
    do
      ()
    done;
    self.create ()
  with M.Found x -> x

let recycle (self : 'a t) (x : 'a) : unit =
  self.clear x;
  while
    match A.get self.cached with
    | Cons (i, _, _) when i >= self.max_size -> false (* drop buf *)
    | old -> not (A.compare_and_set self.cached old (List_with_len.cons x old))
  do
    ()
  done

let with_ (self : 'a t) f =
  let x = alloc self in
  try
    let res = f x in
    recycle self x;
    res
  with e ->
    let bt = Printexc.get_raw_backtrace () in
    recycle self x;
    Printexc.raise_with_backtrace e bt
