let run () =
  Trace.set_process_name "main";
  Trace.set_thread_name "t1";

  let n = ref 0 in

  for _i = 1 to 50 do
    Trace.with_span ~__FILE__ ~__LINE__ "outer.loop" @@ fun _sp ->
    let pseudo_async_sp =
      Trace.enter_explicit_span ~surrounding:None ~__FILE__ ~__LINE__
        "fake_sleep"
    in

    for _j = 2 to 5 do
      incr n;
      Trace.with_span ~__FILE__ ~__LINE__ "inner.loop" @@ fun _sp ->
      Trace.messagef (fun k -> k "hello %d %d" _i _j);
      Trace.message "world";
      Trace.counter_int "n" !n;

      if _j = 2 then (
        (* fake micro sleep *)
        let _sp =
          Trace.enter_explicit_span ~surrounding:(Some pseudo_async_sp)
            ~__FILE__ ~__LINE__ "sub-sleep"
        in
        Thread.delay 0.005;
        Trace.exit_explicit_span _sp
      ) else if _j = 3 then
        (* pretend some task finished. Note that this is not well scoped wrt other spans. *)
        Trace.exit_explicit_span pseudo_async_sp
    done
  done

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout () @@ fun () -> run ()
