open Common_
module Buf = Buf
module Buf_chain = Buf_chain
module Buf_pool = Buf_pool
module Exporter = Exporter
module Collector_fuchsia = Collector_fuchsia
module Writer = Writer

type output =
  [ `File of string
  | `Exporter of Exporter.t
  ]

let get_out_ (out : [< output ]) : Exporter.t =
  match out with
  | `File path ->
    let oc = open_out path in
    Exporter.of_out_channel ~close_channel:true oc
  | `Exporter e -> e

let collector ~out () : Trace_core.Collector.t =
  let exporter = get_out_ out in
  let pid = Trace_util.Mock_.get_pid () in
  let coll_st = Collector_fuchsia.create ~pid ~exporter () in
  Collector_fuchsia.collector coll_st

let setup ?(out = `Env) () =
  match out with
  | `File path -> Trace_core.setup_collector @@ collector ~out:(`File path) ()
  | `Exporter _ as out ->
    let c = collector ~out () in
    Trace_core.setup_collector c
  | `Env ->
    (match Sys.getenv_opt "TRACE" with
    | Some ("1" | "true") ->
      let path = "trace.fxt" in
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | Some path ->
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | None -> ())

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Internal_ = struct
  let mock_all_ () =
    Trace_util.Mock_.mock_all ();
    ()

  let on_tracing_error = on_tracing_error
end
