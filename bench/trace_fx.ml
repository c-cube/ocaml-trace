module Trace = Trace_core

let ( let@ ) = ( @@ )

let work ~dom_idx ~n () : unit =
  Trace_core.set_thread_name (Printf.sprintf "worker%d" dom_idx);
  for _i = 1 to n do
    let%trace _sp = "outer" in
    Trace_core.add_data_to_span _sp [ "i", `Int _i ];
    for _k = 1 to 10 do
      let%trace _sp = "inner" in
      ()
    done;

    (* Thread.delay 1e-6 *)
    if dom_idx = 0 && _i mod 4096 = 0 then (
      let stat = Gc.quick_stat () in
      Trace_core.counter_float "gc.minor" (8. *. stat.minor_words);
      Trace_core.counter_float "gc.major" (8. *. stat.major_words)
    )
  done

let main ~n ~j () : unit =
  let domains =
    Array.init j (fun dom_idx -> Domain.spawn (fun () -> work ~dom_idx ~n ()))
  in

  let%trace () = "join" in
  Array.iter Domain.join domains

let () =
  let@ () = Trace_fuchsia.with_setup () in
  Trace_core.set_process_name "trace_fxt1";
  Trace_core.set_thread_name "main";

  let%trace () = "main" in

  let n = ref 10_000 in
  let j = ref 4 in

  let args =
    [
      "-n", Arg.Set_int n, " number of iterations";
      "-j", Arg.Set_int j, " set number of workers";
    ]
    |> Arg.align
  in
  Arg.parse args ignore "bench1";
  main ~n:!n ~j:!j ()
