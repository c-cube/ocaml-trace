type span = int64
(** A span identifier. *)

type user_data =
  [ `Int of int
  | `String of string
  | `Bool of bool
  | `None
  ]
(** User defined data, generally passed as key/value pairs *)
