module Subscriber = Subscriber
module Exporter = Exporter
module Writer = Writer

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]
(** Output for tracing.

    - [`Stdout] will enable tracing and print events on stdout
    - [`Stderr] will enable tracing and print events on stderr
    - [`File "foo"] will enable tracing and print events into file named "foo"
*)

val subscriber : out:[< output ] -> unit -> Trace_subscriber.t
(** A subscriber emitting TEF traces into [out].
    @since 0.8 *)

val collector : out:[< output ] -> unit -> Trace_core.collector
(** Make a collector that writes into the given output. See {!setup} for more
    details. *)

val setup : ?out:[ output | `Env ] -> unit -> unit
(** [setup ()] installs the collector depending on [out].

    @param out
      can take different values:
      - regular {!output} value to specify where events go
      - [`Env] will enable tracing if the environment variable "TRACE" is set.

    - If it's set to "1", then the file is "trace.json".
    - If it's set to "stdout", then logging happens on stdout (since 0.2)
    - If it's set to "stderr", then logging happens on stdout (since 0.2)
    - Otherwise, if it's set to a non empty string, the value is taken to be the
      file path into which to write. *)

val with_setup : ?out:[ output | `Env ] -> unit -> (unit -> 'a) -> 'a
(** [with_setup () f] (optionally) sets a collector up, calls [f()], and makes
    sure to shutdown before exiting. since 0.2 a () argument was added. *)

(**/**)

module Private_ : sig
  val mock_all_ : unit -> unit
  (** use fake, deterministic timestamps, TID, PID *)

  val on_tracing_error : (string -> unit) ref

  val subscriber_jsonl :
    finally:(unit -> unit) ->
    out:[ `File_append of string | `Output of out_channel ] ->
    unit ->
    Trace_subscriber.t

  val collector_jsonl :
    finally:(unit -> unit) ->
    out:[ `File_append of string | `Output of out_channel ] ->
    unit ->
    Trace_core.collector

  module Event = Event
end

(**/**)
