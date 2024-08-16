module Trace = Trace_core

let ( let@ ) = ( @@ )

let work ~n () : unit =
  for _i = 1 to n do
    let@ _sp =
      Trace.with_span ~__FILE__ ~__LINE__ "outer" ~data:(fun () ->
          [ "i", `Int _i ])
    in
    for _k = 1 to 10 do
      let@ _sp =
        Trace.with_span ~__FILE__ ~__LINE__ "inner" ~data:(fun () ->
            (* add some big data sometimes *)
            if _i mod 100 = 0 && _k = 9 then
              [ "s", `String (String.make 5000 '-') ]
            else
              [])
      in
      ()
    done;

    if _i mod 1000 = 0 then Thread.yield ()
    (* Thread.delay 1e-6 *)
  done

let main ~n ~j ~child () : unit =
  if child then
    work ~n ()
  else
    let@ _sp = Trace.with_span ~__FILE__ ~__LINE__ "parent" in
    let cmd =
      Printf.sprintf "%s --child -n=%d" (Filename.quote Sys.argv.(0)) n
    in
    let procs = Array.init j (fun _ -> Unix.open_process_in cmd) in
    Array.iteri
      (fun idx _ic ->
        let@ _sp =
          Trace.with_span ~__FILE__ ~__LINE__ "wait.child" ~data:(fun () ->
              [ "i", `Int idx ])
        in
        ignore @@ Unix.close_process_in _ic)
      procs

let () =
  let@ () = Trace_tef_tldr.with_setup () in

  let n = ref 10_000 in
  let j = ref 4 in
  let child = ref false in

  let args =
    [
      "-n", Arg.Set_int n, " number of iterations";
      "-j", Arg.Set_int j, " set number of workers";
      "--child", Arg.Set child, " act as child process";
    ]
    |> Arg.align
  in
  Arg.parse args ignore "bench1";
  main ~n:!n ~j:!j ~child:!child ()
