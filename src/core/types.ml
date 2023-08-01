type span = int64
(** A span identifier.

    The meaning of the identifier depends on the collector. *)

type user_data =
  [ `Int of int
  | `String of string
  | `Bool of bool
  | `None
  ]
(** User defined data, generally passed as key/value pairs to
    whatever collector is installed (if any). *)

type explicit_span = {
  span: span;
      (** Identifier for this span. Several explicit spans might share the same
      identifier since we can differentiate between them via [meta]. *)
  meta: Meta_map.t;  (** Metadata for this span (and its context) *)
}
(** Explicit span, with collector-specific metadata *)
