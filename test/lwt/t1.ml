open Lwt.Syntax

let ( let@ ) = ( @@ )

module Barrier = struct
  type t = {
    mutable n: int;
    size: int;
    cond: unit Lwt_condition.t;
  }

  let create size : t = { n = 0; size; cond = Lwt_condition.create () }

  let wait (self : t) : unit Lwt.t =
    self.n <- self.n + 1;
    if self.n >= self.size then (
      (* all reached barrier, reset and wakeup everyone *)
      self.n <- 0;
      Lwt_condition.broadcast self.cond ();
      Lwt.return ()
    ) else
      Lwt_condition.wait self.cond
end

let inner_loop ~off i barrier =
  let rec loop j =
    if j >= 5 then
      Lwt.return ()
    else
      let* () = Lwt_unix.sleep (float off *. 0.01) in
      let* () =
        let@ _sp =
          Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "inner.loop.step"
        in
        Trace.messagef (fun k -> k "hello %d %d" i j);
        Trace.message "world";

        let* () =
          if j = 2 then
            let* () = Lwt_unix.sleep (float off *. 0.01) in
            let@ _sp =
              Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "sub-sleep"
            in
            Lwt_unix.sleep 0.01
          else
            Lwt.return ()
        in

        let* () = Lwt_unix.sleep 0.06 in
        let* () = Barrier.wait barrier in
        Lwt.return ()
      in

      loop (j + 1)
  in
  let@ _sp =
    Trace_lwt.with_span_lwt ~force_toplevel:true ~__FILE__ ~__LINE__
      "inner.loop"
  in
  loop 0

let outer_loop ~off barrier =
  let rec loop i =
    if i = 20 then
      Lwt.return ()
    else
      let* () =
        let* () = Lwt_unix.sleep (float off *. 0.04) in
        let@ _sp =
          Trace_lwt.with_span_lwt ~__FILE__ ~__LINE__ "outer.loop.step"
        in

        let barrier_inner = Barrier.create 2 in
        let* () = inner_loop ~off:0 i barrier_inner
        and* () = inner_loop ~off:1 i barrier_inner in
        let* () = Barrier.wait barrier in
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

  let barrier = Barrier.create 2 in
  let* () = outer_loop ~off:0 barrier and* () = outer_loop ~off:1 barrier in
  Lwt.return ()

let () =
  Trace_tef.Internal_.mock_all_ ();
  Trace_tef.with_setup ~out:`Stdout () @@ fun () -> Lwt_main.run (run ())
