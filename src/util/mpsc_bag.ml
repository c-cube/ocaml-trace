module A = Trace_core.Internal_.Atomic_

type 'a t = { bag: 'a list A.t } [@@unboxed]

let create () =
  let bag = A.make [] in
  { bag }

module Backoff = struct
  type t = int

  let default = 2

  let once (b : t) : t =
    for _i = 1 to b do
      Domain_util.cpu_relax ()
    done;
    min (b * 2) 256
end

let rec add backoff t x =
  let before = A.get t.bag in
  let after = x :: before in
  if not (A.compare_and_set t.bag before after) then
    add (Backoff.once backoff) t x

let[@inline] add t x = add Backoff.default t x

let[@inline] pop_all t : _ list option =
  match A.exchange t.bag [] with
  | [] -> None
  | l -> Some (List.rev l)
