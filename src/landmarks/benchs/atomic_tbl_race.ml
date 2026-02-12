(** Aggressive race condition test *)

open Trace_landmarks

let () =
  let num_domains = Domain.recommended_domain_count () in
  Printf.printf "Testing with %d cores available\n" num_domains;

  let tbl = Trace_landmarks.Atomic_tbl.create () in
  let iterations = 500_000 in
  let shared_keys = 10 in
  let sum_shared = Atomic.make 0 in

  let worker domain_id () =
    let sum_shared_local = ref 0 in
    for i = 0 to iterations - 1 do
      let key =
        if i mod 3 = 0 then (
          incr sum_shared_local;
          Printf.sprintf "shared_%d" (i mod shared_keys)
        ) else
          Printf.sprintf "domain_%d_key_%d" domain_id (i mod 50)
      in
      let counter = Atomic_tbl.find_or_add tbl key (fun () -> Atomic.make 0) in
      Atomic.incr counter;

      if i mod 1000 = 0 then
        for _i = 1 to 50 do
          Trace_util.Domain_util.cpu_relax ()
        done
    done;
    Printf.printf "Domain %d: Completed %d iterations\n%!" domain_id iterations;
    ignore (Atomic.fetch_and_add sum_shared !sum_shared_local : int)
  in

  let start_time = Unix.gettimeofday () in
  let domains = List.init num_domains (fun i -> Domain.spawn (worker i)) in
  List.iter Domain.join domains;
  let elapsed = Unix.gettimeofday () -. start_time in

  (* Verify shared keys *)
  Printf.printf "\n=== Results ===\n";
  Printf.printf "elapsed time: %.3f seconds\n" elapsed;

  let total_shared_count = ref 0 in
  for i = 0 to shared_keys - 1 do
    let key = Printf.sprintf "shared_%d" i in
    match Atomic_tbl.find tbl key with
    | Some counter ->
      let count = Atomic.get counter in
      Printf.printf "  %s: %d\n" key count;
      total_shared_count := !total_shared_count + count
    | None -> ()
  done;

  Printf.printf "\nShared key increments: %d\n" !total_shared_count;
  let total_iterations = num_domains * iterations in
  Printf.printf "\n%d iterations in %.3f seconds (%.4f/s)\n" total_iterations
    elapsed
    (float total_iterations /. elapsed);

  let expected_shared = Atomic.get sum_shared in
  if !total_shared_count <> expected_shared then (
    Printf.eprintf "ERROR: Race condition detected! (expected %d, got %d)\n"
      expected_shared !total_shared_count;
    exit 1
  );

  Printf.printf "\n✓ Race condition test PASSED!\n"
