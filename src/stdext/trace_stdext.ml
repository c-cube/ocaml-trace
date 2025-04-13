
(** Standard extensions *)

open Trace_core

type extension_event +=
  | Link of explicit_span * explicit_span_ctx
  (** [Link (span, ctx)] establishes a link between two spans (one of which is
  only known by context). The link is not a parent-child link, but a causality/relatedness link.
  Each collector is free to interpret this as it wishes. *)

(** Link two spans together. *)
let[@inline] link (es:explicit_span) (ctx:explicit_span_ctx) : unit =
  Trace_core.extension_event (Link (es, ctx))
