(** A global collector.

    The collector, if present, is responsible for collecting messages
    and spans, and storing them, recording them, forward them, or
    offering them to other services and processes.
*)

open Types

let dummy_span : span = Int64.min_int

(** Signature for a collector.

    This is only relevant to implementors of tracing backends; to instrument
    your code you only need to look at the {!Trace} module. *)
module type S = sig
  val enter_span :
    ?__FUNCTION__:string ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    span
  (** Enter a new span. *)

  val exit_span : span -> unit
  (** Exit given span. It can't be exited again. Spans must follow
      a strict stack discipline on each thread. *)

  val message : ?span:span -> data:(string * user_data) list -> string -> unit
  (** Emit a message with associated metadata. *)

  val name_thread : string -> unit
  (** Give a name to the current thread. *)

  val name_process : string -> unit
  (** Give a name to the current process. *)

  val counter_int : string -> int -> unit
  (** Integer counter. *)

  val counter_float : string -> float -> unit
  (** Float counter. *)

  val shutdown : unit -> unit
  (** Shutdown collector, possibly waiting for it to finish sending data. *)
end
