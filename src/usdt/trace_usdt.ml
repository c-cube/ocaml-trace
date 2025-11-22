open Trace_core
module Subscriber = Subscriber

let subscriber_ () : Trace_subscriber.t =
  let sub = Subscriber.create () in
  Subscriber.subscriber sub

let collector_ () : collector =
  let sub = subscriber_ () in
  Trace_subscriber.collector sub

let[@inline] subscriber () : Trace_subscriber.t = subscriber_ ()
let[@inline] collector () : collector = collector_ ()
let setup () = Trace_core.setup_collector @@ collector ()

let with_setup () f =
  setup ();
  Fun.protect ~finally:Trace_core.shutdown f
