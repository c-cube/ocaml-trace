(** Trace. *)

include module type of Types
module Collector = Collector

(** {2 Tracing} *)

val enabled : unit -> bool
(** Is there a collector?
  
    This is fast, so that the traced program can check it before creating
    any span or message *)

val enter_span :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  span

val exit_span : span -> unit

val with_span :
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  (span -> 'a) ->
  'a

val message :
  ?span:span -> ?data:(unit -> (string * user_data) list) -> string -> unit

(* TODO: counter/plot/metric *)

val messagef :
  ?span:span ->
  ?data:(unit -> (string * user_data) list) ->
  ((('a, Format.formatter, unit, unit) format4 -> 'a) -> unit) ->
  unit

val set_thread_name : string -> unit
(** Give a name to the current thread. *)

val set_process_name : string -> unit
(** Give a name to the current process. *)

val counter_int : string -> int -> unit
(** Emit a counter (int) *)

val counter_float : string -> float -> unit
(** Emit a counter (float) *)

(** {2 Collector} *)

type collector = (module Collector.S)

val setup_collector : collector -> unit
(** [setup_collector c] installs [c] as the collector.
    @raise Invalid_argument if there already is an established
    collector. *)

val shutdown : unit -> unit

(**/**)

(* no guarantee of stability *)
module Internal_ : sig
  module Atomic_ = Atomic_
end

(**/**)
