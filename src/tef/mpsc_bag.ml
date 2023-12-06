type 'a t = { bag: 'a list Atomic.t } [@@unboxed]

let create () =
  let bag = Atomic.make [] in
  { bag }

module Backoff = struct
  type t = int

  let default = 2

  let once (b : t) : t =
    for _i = 1 to b do
      Relax_.cpu_relax ()
    done;
    min (b * 2) 256
end

let rec add backoff t x =
  let before = Atomic.get t.bag in
  let after = x :: before in
  if not (Atomic.compare_and_set t.bag before after) then
    add (Backoff.once backoff) t x

let[@inline] add t x = add Backoff.default t x

exception Empty

let[@inline] pop_all t : _ list =
  match Atomic.exchange t.bag [] with
  | [] -> raise_notrace Empty
  | l -> l
