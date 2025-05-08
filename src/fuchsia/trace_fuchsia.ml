open Common_
module Buf = Buf
module Buf_chain = Buf_chain
module Buf_pool = Buf_pool
module Exporter = Exporter
module Subscriber = Subscriber
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

let subscriber ~out () : Sub.t =
  let exporter = get_out_ out in
  let pid =
    if !Trace_subscriber.Private_.mock then
      2
    else
      Unix.getpid ()
  in
  let sub = Subscriber.create ~pid ~exporter () in
  Subscriber.subscriber sub

let collector ~out () = Sub.collector @@ subscriber ~out ()

let setup ?(out = `Env) () =
  match out with
  | `File path -> Trace_core.setup_collector @@ collector ~out:(`File path) ()
  | `Exporter _ as out ->
    let sub = subscriber ~out () in
    Trace_core.setup_collector @@ Sub.collector sub
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

module Mock_ = struct
  let now = ref 0

  (* used to mock timing *)
  let get_now_ns () : int64 =
    let x = !now in
    incr now;
    Int64.(mul (of_int x) 1000L)

  let get_tid_ () : int = 3
end

module Internal_ = struct
  let mock_all_ () =
    Sub.Private_.mock := true;
    Sub.Private_.get_now_ns_ := Mock_.get_now_ns;
    Sub.Private_.get_tid_ := Mock_.get_tid_;
    ()

  let on_tracing_error = on_tracing_error
end
