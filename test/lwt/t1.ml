open Lwt.Syntax

let ( let@ ) = ( @@ )

let inner_loop i =
  let rec loop j =
    if j >= 5 then
      Lwt.return ()
    else
      let* () =
        let@ _sp =
          Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "inner.loop.step"
        in
        Trace.messagef (fun k -> k "hello %d %d" i j);
        Trace.message "world";

        let* () =
          if j = 2 then
            let@ _sp =
              Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "sub-sleep"
            in
            Lwt_unix.sleep 0.010
          else
            Lwt.return ()
        in

        Lwt_unix.sleep 0.006
      in

      loop (j + 1)
  in
  let@ _sp =
    Trace_lwt.with_span_lwt ~force_toplevel:true ~__FILE__ ~__LINE__
      "inner.loop"
  in
  loop 0

let outer_loop () =
  let rec loop i =
    if i = 50 then
      Lwt.return ()
    else
      let* () =
        let@ _sp =
          Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "outer.loop.step"
        in

        let fut_sleep =
          let@ _sp =
            Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "outer.sleep"
          in
          Lwt_unix.sleep 0.09
        in

        let* () = inner_loop i and* () = inner_loop i in
        let* () = fut_sleep in
        Lwt.return ()
      in
      loop (i + 1)
  in

  let@ _sp =
    Trace_lwt.with_span_lwt ~force_toplevel:true ~__FILE__ ~__LINE__
      "outer.loop"
  in
  loop 0

let run () : unit Lwt.t =
  Trace.set_process_name "main";
  Trace.set_thread_name "t1";

  let* () = outer_loop () and* () = outer_loop () in
  Lwt.return ()

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout () @@ fun () -> Lwt_main.run (run ())
