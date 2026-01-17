module Trace = Trace_core

let ( let@ ) = ( @@ )

let work ~n () : unit =
  let@ _sp = Trace.with_span ~__FILE__ ~__LINE__ "work" in
  Trace.add_data_to_span _sp [ "n", `Int n ];

  for _i = 1 to n do
    let@ _sp =
      Trace.with_span ~__FILE__ ~__LINE__ "outer" ~data:(fun () ->
          [ "i", `Int _i ])
    in
    for _k = 1 to 10 do
      let@ _sp = Trace.with_span ~__FILE__ ~__LINE__ "inner" in
      ()
    done
    (* Thread.delay 1e-6 *)
  done

let main ~n ~j () : unit =
  let@ _sp = Trace.with_span ~__FILE__ ~__LINE__ "main" in
  let domains = Array.init j (fun _ -> Domain.spawn (fun () -> work ~n ())) in
  Array.iter Domain.join domains

let () =
  let@ () = Trace_tef.with_setup () in

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
