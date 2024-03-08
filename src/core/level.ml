(** Tracing levels.

    This is similar to log levels in, say, [Logs].
    In a thoroughly instrumented program, there will be a {b lot}
    of spans, and enabling them all in production might slow
    down the application or overwhelm the tracing system; yet
    they might be useful in debug situations.

    @since 0.7 *)

(** Level of tracing. These levels are in increasing order, i.e if
    level [Debug1] is enabled, everything below it (Error, Warning, Info, etc.)
    are also enabled.
    @since 0.7 *)
type t =
  | Error  (** Only errors *)
  | Warning  (** Warnings *)
  | Info
  | Debug1  (** Least verbose debugging level *)
  | Debug2  (** Intermediate verbosity debugging level *)
  | Debug3  (** Maximum verbosity debugging level *)
  | Trace  (** Enable everything (default level) *)

(** @since 0.7 *)
let to_string : t -> string = function
  | Error -> "error"
  | Warning -> "warning"
  | Info -> "info"
  | Debug1 -> "debug1"
  | Debug2 -> "debug2"
  | Debug3 -> "debug3"
  | Trace -> "trace"

let[@inline] leq (a : t) (b : t) : bool = a <= b
