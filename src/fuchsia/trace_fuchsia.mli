(** Fuchsia trace collector.

    This provides a collector for traces that emits data into a file using the
    compact binary
    {{:https://fuchsia.dev/fuchsia-src/reference/tracing/trace-format} Fuchsia
     trace format}. This reduces the tracing overhead compared to [trace-tef],
    at the expense of simplicity. *)

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

val subscriber : out:[< output ] -> unit -> Trace_subscriber.t

val collector : out:[< output ] -> unit -> Trace_core.collector
(** Make a collector that writes into the given output. See {!setup} for more
    details. *)

val setup : ?out:[ output | `Env ] -> unit -> unit
(** [setup ()] installs the collector depending on [out].

    @param out
      can take different values:
      - regular {!output} value to specify where events go
      - [`Env] will enable tracing if the environment variable "TRACE" is set.

    - If it's set to "1", then the file is "trace.fxt".
    - Otherwise, if it's set to a non empty string, the value is taken to be the
      file path into which to write. *)

val with_setup : ?out:[< output | `Env > `Env ] -> unit -> (unit -> 'a) -> 'a
(** [with_setup () f] (optionally) sets a collector up, calls [f()], and makes
    sure to shutdown before exiting. *)

(**/**)

module Internal_ : sig
  val on_tracing_error : (string -> unit) ref

  val mock_all_ : unit -> unit
  (** use fake, deterministic timestamps, TID, PID *)
end

(**/**)
