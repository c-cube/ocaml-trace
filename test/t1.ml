let run () =
  Trace.set_process_name "main";
  Trace.set_thread_name "t1";

  let n = ref 0 in

  for _i = 1 to 50 do
    Trace.with_span ~__FILE__ ~__LINE__ "outer.loop" @@ fun _sp ->
    let pseudo_async_sp =
      Trace.enter_manual_toplevel_span ~__FILE__ ~__LINE__ "fake_sleep"
    in

    for _j = 2 to 5 do
      incr n;
      Trace.with_span ~__FILE__ ~__LINE__ "inner.loop" @@ fun _sp ->
      Trace.messagef (fun k -> k "hello %d %d" _i _j);
      Trace.message "world";
      Trace.counter_int "n" !n;

      Trace.add_data_to_span _sp [ "i", `Int _i ];

      if _j = 2 then (
        Trace.add_data_to_span _sp [ "j", `Int _j ];
        let _sp =
          Trace.enter_manual_sub_span ~parent:pseudo_async_sp
            ~flavor:
              (if _i mod 3 = 0 then
                `Sync
              else
                `Async)
            ~__FILE__ ~__LINE__ "sub-sleep"
        in

        (* fake micro sleep *)
        Thread.delay 0.005;
        Trace.exit_manual_span _sp
      ) else if _j = 3 then (
        (* pretend some task finished. Note that this is not well scoped wrt other spans. *)
        Trace.add_data_to_manual_span pseudo_async_sp [ "slept", `Bool true ];
        Trace.exit_manual_span pseudo_async_sp
      )
    done
  done

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout () @@ fun () -> run ()
