open Common_

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

let collector = Fcollector.create

let setup ?(out = `Env) () =
  match out with
  | `Stderr -> Trace_core.setup_collector @@ Fcollector.create ~out:`Stderr ()
  | `Stdout -> Trace_core.setup_collector @@ Fcollector.create ~out:`Stdout ()
  | `File path ->
    Trace_core.setup_collector @@ Fcollector.create ~out:(`File path) ()
  | `Env ->
    (match Sys.getenv_opt "TRACE" with
    | Some ("1" | "true") ->
      let path = "trace.fxt" in
      let c = Fcollector.create ~out:(`File path) () in
      Trace_core.setup_collector c
    | Some "stdout" ->
      Trace_core.setup_collector @@ Fcollector.create ~out:`Stdout ()
    | Some "stderr" ->
      Trace_core.setup_collector @@ Fcollector.create ~out:`Stderr ()
    | Some path ->
      let c = Fcollector.create ~out:(`File path) () in
      Trace_core.setup_collector c
    | None -> ())

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Internal_ = struct
  let mock_all_ = Fcollector.Internal_.mock_all_
  let on_tracing_error = on_tracing_error
end
