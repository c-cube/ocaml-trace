(** A global collector.

    The collector, if present, is responsible for collecting messages
    and spans, and storing them, recording them, forward them, or
    offering them to other services and processes.
*)

open Types

let dummy_span : span = Int64.min_int

let dummy_explicit_span : explicit_span =
  { span = dummy_span; meta = Meta_map.empty }

(** Signature for a collector.

    This is only relevant to implementors of tracing backends; to instrument
    your code you only need to look at the {!Trace} module. *)
module type S = sig
  val with_span :
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    (span -> 'a) ->
    'a
  (** Run the function in a new span.

      This replaces the previous [enter_span] and [exit_span] which were too flexible
      to be efficient to implement in async contexts.
     @since 0.3 *)

  val enter_span :
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    span
  (** Enter a new implicit span. For many uses cases, {!with_span} will
      be easier to use.
      @since 0.6 *)

  val exit_span : span -> unit
  (** Exit span. This should be called on the same thread
      as the corresponding {!enter_span}, and nest properly with
      other calls to enter/exit_span and {!with_span}.
      @since 0.6 *)

  val add_data_to_span : span -> (string * user_data) list -> unit
  (** @since Adds data to the current span.
      0.4 *)

  val message : ?span:span -> data:(string * user_data) list -> string -> unit
  (** Emit a message with associated metadata. *)

  val name_thread : string -> unit
  (** Give a name to the current thread. *)

  val name_process : string -> unit
  (** Give a name to the current process. *)

  val counter_int : data:(string * user_data) list -> string -> int -> unit
  (** Integer counter. *)

  val counter_float : data:(string * user_data) list -> string -> float -> unit
  (** Float counter. *)

  val shutdown : unit -> unit
  (** Shutdown collector, possibly waiting for it to finish sending data. *)
end
