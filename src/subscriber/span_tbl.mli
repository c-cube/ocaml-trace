(** A table that can be used to remember information about spans.

    This is convenient when we want to rememner information from a span begin,
    when dealing with the corresponding span end.

    {b NOTE}: this is thread safe when threads are enabled. *)

open Trace_core

type 'v t

val create : unit -> 'v t
val add : 'v t -> span -> 'v -> unit

val find_exn : 'v t -> span -> 'v
(** @raise Not_found if information isn't found *)

val remove : _ t -> span -> unit
(** Remove the span if present *)

val to_list : 'v t -> (span * 'v) list
