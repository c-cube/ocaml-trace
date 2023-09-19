(** Wrapper for tracing with Lwt.

    @since NEXT_RELEASE. *)

include module type of Trace_core

val with_span_lwt :
  ?parent:explicit_span ->
  ?force_toplevel:bool ->
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  (span -> 'a Lwt.t) ->
  'a Lwt.t
(** [with_span_lwt ~__FILE__ ~__LINE__ name f] calls [f span]
    where [span] is a new span named with [name]. The span is
    traced as being asynchronous, so each collector might represent
    it differently.

    @param force_toplevel if true, this span will not have a parent even if
      there is one in the implicit context; ie it create a new
      {!Trace_core.enter_manual_toplevel_span} in any  case.
    @param parent an explicit parent, which bypasses the implicit context.

    @since NEXT_RELEASE *)

val with_span :
  ?parent:explicit_span ->
  ?force_toplevel:bool ->
  ?__FUNCTION__:string ->
  __FILE__:string ->
  __LINE__:int ->
  ?data:(unit -> (string * user_data) list) ->
  string ->
  (span -> 'a) ->
  'a
(** [with_span ~__FILE__ ~__LINE__ name f] calls [f span]
    where [span] is a new span named with [name]. The span is
    traced as being asynchronous, so each collector might represent
    it differently.

    If [f] returns an ['a Lwt.t] future, use [with_span_lwt] instead.

    @param force_toplevel if true, this span will not have a parent even if
      there is one in the implicit context; ie it create a new
      {!Trace_core.enter_manual_toplevel_span} in any  case.
    @param parent an explicit parent, which bypasses the implicit context.

    @since NEXT_RELEASE *)
