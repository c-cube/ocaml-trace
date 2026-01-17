open Trace_core

module type TRACKED_SPAN = sig
  include Hashtbl.HashedType

  val of_span : Trace_core.span -> t option

  val name : t -> string
  (** Just the name of the span, nothing else *)
end

type unclosed_spans = {
  num: int;
  by_name: (string * int) list;
}

val track :
  ?on_lingering_spans:[ `Out of out_channel | `Call of unclosed_spans -> unit ] ->
  (module TRACKED_SPAN) ->
  Collector.t ->
  Collector.t
(** Modify the enter/exit span functions to track the set of spans that are
    open, and warn at the end if some are not closed.
    @param on_lingering_spans what to do with the non-closed spans *)
