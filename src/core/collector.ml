(** A global collector.

    The collector, if present, is responsible for collecting messages and spans,
    and storing them, recording them, forward them, or offering them to other
    services and processes. *)

open Types

let dummy_span : span = Int64.min_int
let dummy_trace_id : trace_id = "<dummy>"

let dummy_explicit_span : explicit_span =
  { span = dummy_span; trace_id = dummy_trace_id; meta = Meta_map.empty }

let dummy_explicit_span_ctx : explicit_span_ctx =
  { span = dummy_span; trace_id = dummy_trace_id }

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
      @since 0.3 *)

  val enter_span :
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    span
  (** Enter a new implicit span. For many uses cases, {!with_span} will be
      easier to use.
      @since 0.6 *)

  val exit_span : span -> unit
  (** Exit span. This should be called on the same thread as the corresponding
      {!enter_span}, and nest properly with other calls to enter/exit_span and
      {!with_span}.
      @since 0.6 *)

  val enter_manual_span :
    parent:explicit_span_ctx option ->
    flavor:[ `Sync | `Async ] option ->
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    data:(string * user_data) list ->
    string ->
    explicit_span
  (** Enter an explicit span. Surrounding scope, if any, is provided by
      [parent], and this function can store as much metadata as it wants in the
      hmap in the {!explicit_span}'s [meta] field.

      {b NOTE} the [parent] argument is now an {!explicit_span_ctx} and not an
      {!explicit_span} since 0.10.

      This means that the collector doesn't need to implement contextual storage
      mapping {!span} to scopes, metadata, etc. on its side; everything can be
      transmitted in the {!explicit_span}.
      @since 0.3 *)

  val exit_manual_span : explicit_span -> unit
  (** Exit an explicit span.
      @since 0.3 *)

  val add_data_to_span : span -> (string * user_data) list -> unit
  (** @since Adds data to the current span.

      0.4 *)

  val add_data_to_manual_span :
    explicit_span -> (string * user_data) list -> unit
  (** Adds data to the given span.
      @since 0.4 *)

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

  val extension_event : extension_event -> unit
  (** Handle an extension event. A collector {b MUST} simple ignore events it
      doesn't know, and return [()] silently.
      @since 0.8 *)

  val shutdown : unit -> unit
  (** Shutdown collector, possibly waiting for it to finish sending data. *)
end
