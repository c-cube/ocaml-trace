(** Simple test for Atomic_tbl *)

open Trace_landmarks

let () =
  let tbl = Atomic_tbl.create () in

  (* Insert and verify identity *)
  let v1 = Atomic_tbl.find_or_add tbl "foo" (fun () -> ref 42) in
  let v2 = Atomic_tbl.find_or_add tbl "bar" (fun () -> ref 99) in
  let v3 = Atomic_tbl.find_or_add tbl "foo" (fun () -> ref 999) in

  assert (v1 == v3);
  (* Same key returns same value *)
  assert (v1 != v2);
  assert (!v1 = 42);
  assert (!v2 = 99);
  assert (!v3 = 42);

  (* Test find *)
  (match Atomic_tbl.find tbl "foo" with
  | Some v -> assert (v == v1)
  | None -> assert false);

  (match Atomic_tbl.find tbl "nonexistent" with
  | Some _ -> assert false
  | None -> ());

  print_endline "all Atomic_tbl tests passed!"
