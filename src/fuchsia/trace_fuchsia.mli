(** Fuchsia trace collector.

    This provides a collector for traces that emits data into a file using the
    compact binary
    {{:https://fuchsia.dev/fuchsia-src/reference/tracing/trace-format} Fuchsia
     trace format}. This reduces the tracing overhead compared to [trace-tef],
    at the expense of simplicity. *)

val collector :
  out:[ `File of string | `Stderr | `Stdout ] -> unit -> Trace_core.collector
(** Make a collector that writes into the given output. See {!setup} for more
    details. *)

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

val setup : ?out:[ output | `Env ] -> unit -> unit
(** [setup ()] installs the collector depending on [out].

    @param out
      can take different values:
      - regular {!output} value to specify where events go
      - [`Env] will enable tracing if the environment variable "TRACE" is set.

    - If it's set to "1", then the file is "trace.fxt".
    - If it's set to "stdout", then logging happens on stdout (since 0.2)
    - If it's set to "stderr", then logging happens on stdout (since 0.2)
    - Otherwise, if it's set to a non empty string, the value is taken to be the
      file path into which to write. *)

val with_setup : ?out:[ output | `Env ] -> unit -> (unit -> 'a) -> 'a
(** [with_setup () f] (optionally) sets a collector up, calls [f()], and makes
    sure to shutdown before exiting. *)

(**/**)

module Internal_ : sig
  val on_tracing_error : (string -> unit) ref
end

(**/**)
