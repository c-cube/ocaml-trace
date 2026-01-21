(** A simple span.

    This is a concrete representation of spans that is convenient to manipulate.

    @since NEXT_RELEASE *)

open Trace_core

type span_flavor =
  [ `Sync
  | `Async
  ]

type t = {
  name: string;
  __FUNCTION__: string option;
  __FILE__: string;
  __LINE__: int;
  time_ns: int64;  (** Time the span was entered. *)
  mutable time_exit_ns: int64;
      (** Time the span was exited. Set at exit, [Int64.max_int] otherwise *)
  tid: int;  (** Thread in which span was created *)
  trace_id: int64;  (** For async spans *)
  parent: parent;
  flavor: span_flavor;
  params: extension_parameter list;
  mutable data: (string * Trace_core.user_data) list;
      (** Modified by [add_data_to_span] *)
}
(** The type of spans used by all subscribers. *)

type Trace_core.span +=
  | Span_simple of t  (** How to turn a {!Simple_span.t} into a {!span}. *)
