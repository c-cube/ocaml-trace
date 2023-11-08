type 'a t = {
  tail: 'a list Atomic.t;
  head: 'a list ref;
}

let create () =
  let tail = Atomic.make [] in
  (* padding *)
  ignore (Sys.opaque_identity (Array.make 16 ()));
  let head = ref [] in
  { tail; head }

module Backoff = struct
  type t = int

  let default = 2

  let once (b : t) : t =
    let actual_b = b + Random.int 4 in
    for _i = 1 to actual_b do
      Relax_.cpu_relax ()
    done;
    min (b * 2) 256
end

let rec enqueue backoff t x =
  let before = Atomic.get t.tail in
  let after = x :: before in
  if not (Atomic.compare_and_set t.tail before after) then
    enqueue (Backoff.once backoff) t x

let enqueue t x = enqueue Backoff.default t x

exception Empty

let dequeue t =
  match !(t.head) with
  | x :: xs ->
    t.head := xs;
    x
  | [] ->
    (match Atomic.exchange t.tail [] with
    | [] -> raise_notrace Empty
    | [ x ] -> x
    | x :: xs ->
      (match List.rev_append [ x ] xs with
      | x :: xs ->
        t.head := xs;
        x
      | [] -> assert false))

let dequeue_all t : _ list =
  match !(t.head) with
  | _ :: _ as l ->
    t.head := [];
    l
  | [] ->
    (match Atomic.exchange t.tail [] with
    | [] -> raise_notrace Empty
    | l -> List.rev l)
