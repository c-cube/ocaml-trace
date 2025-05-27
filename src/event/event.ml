(** Events.

    Each callback in a subscriber corresponds to an event, which can be for
    example queued somewhere or batched for further processing. *)

open Trace_core
module Sub = Trace_subscriber

(** An event with TEF/fuchsia semantics *)
type t =
  | E_tick
  | E_init of { time_ns: int64 }
  | E_shutdown of { time_ns: int64 }
  | E_message of {
      tid: int;
      msg: string;
      time_ns: int64;
      data: (string * Sub.user_data) list;
    }
  | E_define_span of {
      tid: int;
      name: string;
      time_ns: int64;
      id: span;
      fun_name: string option;
      data: (string * Sub.user_data) list;
    }
  | E_exit_span of {
      id: span;
      time_ns: int64;
    }
  | E_add_data of {
      id: span;
      data: (string * Sub.user_data) list;
    }
  | E_enter_manual_span of {
      tid: int;
      name: string;
      time_ns: int64;
      id: trace_id;
      flavor: Sub.flavor option;
      fun_name: string option;
      data: (string * Sub.user_data) list;
    }
  | E_exit_manual_span of {
      tid: int;
      name: string;
      time_ns: int64;
      flavor: Sub.flavor option;
      data: (string * Sub.user_data) list;
      id: trace_id;
    }
  | E_counter of {
      name: string;
      tid: int;
      time_ns: int64;
      n: float;
    }
  | E_name_process of { name: string }
  | E_name_thread of {
      tid: int;
      name: string;
    }
  | E_extension_event of {
      tid: int;
      time_ns: int64;
      ext: Trace_core.extension_event;
    }
