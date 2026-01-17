(** Combine multiple collectors into one *)

open Trace_core

val combine_l : Collector.t list -> Collector.t
(** Combine multiple collectors, ie return a collector that forwards to every
    collector in the list. *)

val combine : Collector.t -> Collector.t -> Collector.t
(** [combine s1 s2] is a collector that forwards every call to [s1] and [s2]
    both. *)
