module Trace_id = Trace_util.Trace_id64

type trace_id = Trace_id.t

type Trace_core.span +=
  | Span_tef_sync of {
      pid: int;
      tid: int;
      name: string;
      start_us: float;
      mutable args: (string * Trace_core.user_data) list;
    }
  | Span_tef_async of {
      pid: int;
      tid: int;
      name: string;
      trace_id: trace_id;
      mutable args: (string * Trace_core.user_data) list;
    }
