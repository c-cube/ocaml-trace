open Trace_core
module Trace_id = Trace_util.Trace_id64

type trace_id = Trace_id.t

type Trace_core.span +=
  | Span_fuchsia_sync of {
      __FUNCTION__: string option;
      pid: int;
      tid: int;
      name: string;
      start_ns: int64;
      mutable args: (string * Trace_core.user_data) list;
    }
  | Span_fuchsia_async of {
      pid: int;
      tid: int;
      name: string;
      trace_id: trace_id;
      mutable args: (string * Trace_core.user_data) list;
    }
