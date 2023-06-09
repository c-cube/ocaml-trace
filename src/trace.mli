(** Trace. *)

include module type of Types

(** {2 Tracing} *)

val enabled : unit -> bool

val create_span :
  ?__FUNCTION__:string -> __FILE__:string -> __LINE__:int -> string -> span

val exit_span : span -> unit

val with_ :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  string ->
  (span -> 'a) ->
  'a

val message :
  ?__FUNCTION__:string -> __FILE__:string -> __LINE__:int -> string -> unit

val messagef :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ((('a, Format.formatter, unit, unit) format4 -> 'a) -> unit) ->
  unit

(** {2 Collector} *)

type collector = (module Collector.S)

val setup_collector : collector -> unit
(** [setup_collector c] installs [c] as the collector.
    @raise Invalid_argument if there already is an established
    collector. *)

val shutdown : unit -> unit
