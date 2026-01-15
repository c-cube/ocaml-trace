(** Subscriber span.

    This is the concrete representation of spans used in [Trace_subscriber].

    @since NEXT_RELEASE *)

open Trace_core

type span_id = int64
(** Unique ID *)

type trace_id = int64
(** Unique trace ID *)

let dummy_span_id = Int64.min_int

type span_flavor =
  [ `Sync
  | `Async
  ]

type t = {
  id: span_id;
  name: string;
  __FUNCTION__: string option;
  __FILE__: string;
  __LINE__: int;
  time_ns: int64;  (** Time the span was entered. *)
  mutable time_exit_ns: int64;
      (** Time the span was exited. Set at exit, [Int64.max_int] otherwise *)
  trace_id: trace_id;
  tid: int;  (** Thread in which span was created *)
  parent: parent;
  flavor: span_flavor;
  params: extension_parameter list;
  mutable data: (string * Trace_core.user_data) list;
      (** Modified by [add_data_to_span] *)
}
(** The type of spans used by all subscribers. *)
