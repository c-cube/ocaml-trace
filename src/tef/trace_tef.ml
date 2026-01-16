open Trace_core
module Collector_tef = Collector_tef
module Exporter = Exporter
module Writer = Writer
module Types = Types

let block_signals () =
  try
    ignore
      (Unix.sigprocmask SIG_BLOCK
         [
           Sys.sigterm;
           Sys.sigpipe;
           Sys.sigint;
           Sys.sigchld;
           Sys.sigalrm;
           Sys.sigusr1;
           Sys.sigusr2;
         ]
        : _ list)
  with _ -> ()

(** Thread that simply regularly "ticks", sending events to the background
    thread so it has a chance to write to the file *)
let tick_thread (c : Collector_tef.t) : unit =
  block_signals ();
  while Collector_tef.active c do
    Thread.delay 0.5;
    Collector_tef.flush c
  done

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

let collector_ ~(finally : unit -> unit) ~out ~(mode : [ `Single | `Jsonl ]) ()
    : Collector.t =
  let jsonl = mode = `Jsonl in
  let oc, must_close =
    match out with
    | `Stdout -> stdout, false
    | `Stderr -> stderr, false
    | `File path -> open_out path, true
    | `File_append path ->
      open_out_gen [ Open_creat; Open_wronly; Open_append ] 0o644 path, true
    | `Output oc -> oc, false
  in
  let pid = Trace_util.Mock_.get_pid () in

  let exporter = Exporter.of_out_channel oc ~jsonl ~close_channel:must_close in
  let exporter =
    {
      exporter with
      close =
        (fun () ->
          exporter.close ();
          finally ());
    }
  in
  let coll_st = Collector_tef.create ~pid ~exporter () in
  let _t_tick : Thread.t = Thread.create tick_thread coll_st in
  Collector_tef.collector coll_st

let[@inline] collector ~out () : collector =
  collector_ ~finally:ignore ~mode:`Single ~out ()

open struct
  let register_atexit =
    let has_registered = ref false in
    fun () ->
      if not !has_registered then (
        has_registered := true;
        at_exit Trace_core.shutdown
      )
end

let setup ?(out = `Env) () =
  register_atexit ();
  match out with
  | `Stderr -> Trace_core.setup_collector @@ collector ~out:`Stderr ()
  | `Stdout -> Trace_core.setup_collector @@ collector ~out:`Stdout ()
  | `File path -> Trace_core.setup_collector @@ collector ~out:(`File path) ()
  | `Env ->
    (match Sys.getenv_opt "TRACE" with
    | Some ("1" | "true") ->
      let path = "trace.json" in
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | Some "stdout" -> Trace_core.setup_collector @@ collector ~out:`Stdout ()
    | Some "stderr" -> Trace_core.setup_collector @@ collector ~out:`Stderr ()
    | Some path ->
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | None -> ())

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Private_ = struct
  let mock_all_ () =
    Trace_util.Mock_.mock_all ();
    ()

  let on_tracing_error = Collector_tef.on_tracing_error

  let collector_jsonl ~finally ~out () : collector =
    collector_ ~finally ~mode:`Jsonl ~out ()

  module Event = Event
end
