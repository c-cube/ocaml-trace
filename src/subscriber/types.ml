(** Some core types for subscribers. *)

type user_data =
  | U_bool of bool
  | U_float of float
  | U_int of int
  | U_none
  | U_string of string
      (** A non polymorphic-variant version of {!Trace_core.user_data} *)

type flavor =
  | Sync
  | Async  (** A non polymorphic-variant version of {!Trace_core.flavor} *)
