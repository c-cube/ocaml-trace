(** Common types definitions.

    The type [trace_id] was added in 0.10 and removed in NEXT_RELEASE, as it's
    simply more flexible to use a meta-map ([Hmap.t] in the better case). *)

type span = int64
(** A span identifier.

    The meaning of the identifier depends on the collector. *)

type user_data =
  [ `Int of int
  | `String of string
  | `Bool of bool
  | `Float of float
  | `None
  ]
(** User defined data, generally passed as key/value pairs to whatever collector
    is installed (if any). *)

type span_flavor =
  [ `Sync
  | `Async
  ]
(** Some information about the span.
    @since NEXT_RELEASE *)

type explicit_span_ctx = {
  meta: Meta_map.t;
      (** Metadata for this span and its context. This can be used to store
          trace IDs, attributes, etc. in a collector-specific way. *)
}
[@@unboxed]
(** A context, passed around for async traces. It might not correspond to any
    span created via [Trace] at all, e.g. it might be built in a HTTP handler
    from a {{:https://www.w3.org/TR/trace-context/} W3C trace contxt} header.

    @since 0.10

    The fields [span] and [trace_id] were removed in NEXT_RELEASE. Please use
    the meta map instead. *)

type explicit_span = {
  span: span;
      (** Identifier for this span. Several explicit spans might share the same
          identifier since we can differentiate between them via [meta]. *)
  mutable meta: Meta_map.t;
      (** Metadata for this span (and its context). This can be used by
          collectors to carry collector-specific information from the beginning
          of the span, to the end of the span. *)
}
(** Explicit span, with collector-specific metadata. This is richer than
    {!explicit_span_ctx} but not intended to be passed around (or sent across
    the wire), unlike {!explicit_span_ctx}.

    The field [trace_id] was removed in NEXT_RELEASE, please use the meta map
    instead. *)

type extension_event = ..
(** An extension event, used to add features that are backend specific or simply
    not envisioned by [trace].
    @since 0.8 *)
