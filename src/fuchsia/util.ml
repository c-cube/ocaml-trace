(** How many bytes are missing for [n] to be a multiple of 8 *)
let[@inline] missing_to_round (n : int) : int = lnot (n - 1) land 0b111

(** Round up to a multiple of 8 *)
let[@inline] round_to_word (n : int) : int = n + (lnot (n - 1) land 0b111)
