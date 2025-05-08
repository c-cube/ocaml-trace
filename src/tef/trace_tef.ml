open Trace_core
module Subscriber = Subscriber
module Exporter = Exporter
module Writer = Writer

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
let tick_thread (sub : Subscriber.t) : unit =
  block_signals ();
  while Subscriber.active sub do
    Thread.delay 0.5;
    Subscriber.flush sub
  done

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

let subscriber_ ~finally ~out ~(mode : [ `Single | `Jsonl ]) () :
    Trace_subscriber.t =
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
  let pid =
    if !Trace_subscriber.Private_.mock then
      2
    else
      Unix.getpid ()
  in

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
  let sub = Subscriber.create ~pid ~exporter () in
  let _t_tick : Thread.t = Thread.create tick_thread sub in
  Subscriber.subscriber sub

let collector_ ~(finally : unit -> unit) ~(mode : [ `Single | `Jsonl ]) ~out ()
    : collector =
  let sub = subscriber_ ~finally ~mode ~out () in
  Trace_subscriber.collector sub

let[@inline] subscriber ~out () : Trace_subscriber.t =
  subscriber_ ~finally:ignore ~mode:`Single ~out ()

let[@inline] collector ~out () : collector =
  collector_ ~finally:ignore ~mode:`Single ~out ()

let setup ?(out = `Env) () =
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

module Mock_ = struct
  let now = ref 0

  (* used to mock timing *)
  let get_now_ns () : int64 =
    let x = !now in
    incr now;
    Int64.(mul (of_int x) 1000L)

  let get_tid_ () : int = 3
end

module Private_ = struct
  let mock_all_ () =
    Trace_subscriber.Private_.mock := true;
    Trace_subscriber.Private_.get_now_ns_ := Mock_.get_now_ns;
    Trace_subscriber.Private_.get_tid_ := Mock_.get_tid_;
    ()

  let on_tracing_error = Subscriber.on_tracing_error

  let subscriber_jsonl ~finally ~out () =
    subscriber_ ~finally ~mode:`Jsonl ~out ()

  let collector_jsonl ~finally ~out () : collector =
    collector_ ~finally ~mode:`Jsonl ~out ()

  module Event = Event
end
