(** Lock-free thread-safe hash table *)

module Str_map = Map.Make (String)

type 'a t = { entries: 'a Str_map.t Atomic.t array } [@@unboxed]

let n_slots_log = 7
let n_slots = 1 lsl n_slots_log
let slot_mask = n_slots - 1

let create () : _ t =
  { entries = Array.init n_slots (fun _ -> Atomic.make Str_map.empty) }

(* fnv-1a *)
let[@inline] hash_string s : int =
  let h = ref 1166136261l in
  for i = 0 to String.length s - 1 do
    let c = Int32.of_int (Char.code (String.unsafe_get s i)) in
    h := Int32.(mul (logxor !h c) 16777619l)
  done;
  Int32.to_int !h

let[@inline] find_exn self key =
  let hash = hash_string key in
  let slot = self.entries.(hash land slot_mask) in
  let m = Atomic.get slot in
  Str_map.find key m

let rec add_ slot k init =
  let m = Atomic.get slot in
  match Str_map.find k m with
  | v -> v
  | exception Not_found ->
    let v = init () in
    let m' = Str_map.add k v m in
    if Atomic.compare_and_set slot m m' then
      v
    else (
      Trace_util.Domain_util.cpu_relax ();
      add_ slot k init
    )

let[@inline] find_or_add self k init =
  let hash = hash_string k in
  let slot = self.entries.(hash land slot_mask) in
  match Str_map.find k (Atomic.get slot) with
  | v -> v (* fast path *)
  | exception Not_found -> add_ slot k init

let find self k = try Some (find_exn self k) with Not_found -> None
