open Trace

val collector :
  out:[ `File of string | `Stderr | `Stdout ] -> unit -> Trace.collector
(** Make a collector that writes into the given output.
    See {!setup} for more details. *)

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]
(** Output for tracing.

    - [`Stdout] will enable tracing and print events on stdout
    - [`Stderr] will enable tracing and print events on stderr
    - [`File "foo"] will enable tracing and print events into file
        named "foo"
*)

val setup : ?out:[ output | `Env ] -> unit -> unit
(** [setup ()] installs the collector depending on [out].

    @param out can take different values:
    - regular {!output} value to specify where events go
    - [`Env] will enable tracing if the environment
      variable "TRACE" is set.

      If it's set to anything but "1", the value is taken
      to be the file path into which to write.
      If it's set to "1", then the file is "trace.json".
*)

val with_setup : ?out:[ output | `Env ] -> (unit -> 'a) -> 'a
(** Setup, and make sure to shutdown before exiting *)

(**/**)

module Internal_ : sig
  val use_mock_mtime_ : unit -> unit
  (* use fake, deterministic timestamps *)
end

(**/**)
