(** Helper to track which spans never get closed. *)

open Trace_core

type unclosed_spans = {
  num: int;
  by_name: (string * int) list;
}

val track :
  ?on_lingering_spans:[ `Out of out_channel | `Call of unclosed_spans -> unit ] ->
  Collector.t ->
  Collector.t
(** Modify the enter/exit span functions to track the set of spans that are
    open, and warn at the end if some are not closed.

    implementation notes: for now this uses a regular {!Hashtbl} protected by a
    mutex, so runtime overhead isn't trivial.

    @param on_lingering_spans what to do with the non-closed spans *)
