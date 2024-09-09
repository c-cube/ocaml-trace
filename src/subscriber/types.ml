type user_data =
  | U_bool of bool
  | U_float of float
  | U_int of int
  | U_none
  | U_string of string

type flavor =
  | Sync
  | Async
