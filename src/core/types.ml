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
(** User defined data, generally passed as key/value pairs to
    whatever collector is installed (if any). *)
