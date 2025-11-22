module Subscriber = Subscriber

val subscriber : unit -> Trace_subscriber.t
(** A subscriber based on USDT probes *)

val collector : unit -> Trace_core.collector
(** A collector based on USDT probes. *)

val setup : unit -> unit
(** [setup ()] installs the collector based on USDT probes. *)

val with_setup : unit -> (unit -> 'a) -> 'a
(** [with_setup () f] (optionally) sets a collector up, calls [f()], and makes
    sure to shutdown before exiting. *)
