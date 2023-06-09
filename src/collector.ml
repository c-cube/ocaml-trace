(** A global collector.

    The collector, if present, is responsible for collecting messages
    and spans, and storing them, recording them, forward them, or
    offering them to other services and processes.
*)

open Types

let dummy_span : span = Int64.min_int

module type S = sig
  val enabled : unit -> bool
  (** Is the collector enabled? This should be extremely fast so that
      the traced program can check it before creating any span or
      message *)

  val create_span :
    ?__FUNCTION__:string -> __FILE__:string -> __LINE__:int -> string -> span

  val exit_span : span -> unit

  val message :
    ?__FUNCTION__:string -> __FILE__:string -> __LINE__:int -> string -> unit

  val shutdown : unit -> unit
  (** Shutdown collector, possibly waiting for it to finish sending data. *)
end
