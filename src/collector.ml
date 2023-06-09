(** A global collector.

    The collector, if present, is responsible for collecting messages
    and spans, and storing them, recording them, forward them, or
    offering them to other services and processes.
*)

open Types

let dummy_span : span = Int64.min_int

module type S = sig
  val enter_span :
    ?__FUNCTION__:string ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    span

  val exit_span : span -> unit
  val message : ?span:span -> data:(string * user_data) list -> string -> unit

  val name_thread : string -> unit
  (** Give a name to the current thread *)

  val name_process : string -> unit
  (** Give a name to the current process *)

  val shutdown : unit -> unit
  (** Shutdown collector, possibly waiting for it to finish sending data. *)
end
