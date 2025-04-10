type span = int64
(** A span identifier.

    The meaning of the identifier depends on the collector. *)

type trace_id = string
(** A bytestring representing a (possibly distributed) trace made of async spans.
    With opentelemetry this is 16 bytes.
    @since NEXT_RELEASE *)

type user_data =
  [ `Int of int
  | `String of string
  | `Bool of bool
  | `Float of float
  | `None
  ]
(** User defined data, generally passed as key/value pairs to
    whatever collector is installed (if any). *)

type explicit_span_ctx = {
  span: span;  (** The current span *)
  trace_id: trace_id;  (** The trace this belongs to *)
}
(** A context, passed around for async traces.
    @since NEXT_RELEASE *)

type explicit_span = {
  span: span;
      (** Identifier for this span. Several explicit spans might share the same
      identifier since we can differentiate between them via [meta]. *)
  trace_id: trace_id;  (** The trace this belongs to *)
  mutable meta: Meta_map.t;
      (** Metadata for this span (and its context). This can be used by collectors to
        carry collector-specific information from the beginning
        of the span, to the end of the span. *)
}
(** Explicit span, with collector-specific metadata.
    This is richer than {!explicit_span_ctx} but not intended to be passed around
    (or sent across the wire), unlike {!explicit_span_ctx}. *)

type extension_event = ..
(** An extension event, used to add features that are backend specific
    or simply not envisioned by [trace].
  @since 0.8 *)
