(** Shim that just forwards to {!Trace_core}.

    The reason is, [Trace] is already defined in the compiler libs and can clash
    with this module inside a toplevel. So it's safer to only depend on
    [Trace_core] in libraries that might end up used in a toplevel. *)

include Trace_core
