let run () =
  for _i = 1 to 50 do
    Trace.with_span ~__FUNCTION__ ~__FILE__ ~__LINE__ "outer.loop" @@ fun _sp ->
    for _j = 2 to 5 do
      Trace.with_span ~__FILE__ ~__LINE__ "inner.loop" @@ fun _sp ->
      Trace.messagef ~__FILE__ ~__LINE__ (fun k -> k "hello %d %d" _i _j)
    done
  done

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout @@ fun () -> run ()
