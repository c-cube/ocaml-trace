(** Sequential version for comparison *)

open Trace_landmarks

let () =
  Printf.printf "Running SEQUENTIAL version\n%!";

  let tbl = Atomic_tbl.create () in
  let iterations = 50000 in
  let shared_keys = 10 in

  let start_time = Unix.gettimeofday () in

  for thread_id = 0 to 7 do
    for i = 0 to iterations - 1 do
      let key =
        if i mod 3 = 0 then
          Printf.sprintf "shared_%d" (i mod shared_keys)
        else
          Printf.sprintf "domain_%d_key_%d" thread_id i
      in
      let counter = Atomic_tbl.find_or_add tbl key (fun () -> Atomic.make 0) in
      Atomic.incr counter;

      if i mod 1000 = 0 then (
        let _ = List.fold_left ( + ) 0 (List.init 100 (fun x -> x)) in
        ()
      )
    done
  done;

  let elapsed = Unix.gettimeofday () -. start_time in
  Printf.printf "Elapsed time: %.3f seconds\n" elapsed;
  Printf.printf "✓ Sequential test completed\n"
