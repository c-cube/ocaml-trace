let ( let@ ) = ( @@ )

let run () =
  Trace.set_process_name "main";
  Trace.set_thread_name "t1";

  let n = ref 0 in

  for _i = 1 to 50 do
    Trace.with_span ~__FILE__ ~__LINE__ "outer.loop" @@ fun _sp ->
    for _j = 2 to 5 do
      incr n;
      Trace.with_span ~__FILE__ ~__LINE__ "inner.loop" @@ fun _sp ->
      Trace.messagef (fun k -> k "hello %d %d" _i _j);
      Trace.message "world";
      Trace.counter_int "n" !n;

      Trace.add_data_to_span _sp [ "i", `Int _i ];

      if _j = 2 then (
        Trace.add_data_to_span _sp [ "j", `Int _j ];
        let@ _sp = Trace.with_span ~__LINE__ ~__FILE__ "sub-sleep" in

        (* fake micro sleep *)
        Thread.delay 0.005
      )
    done
  done

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout () @@ fun () -> run ()
