open Trace_core

(** An event, specialized for TEF *)
type t =
  | E_tick
  | E_message of {
      tid: int;
      msg: string;
      time_us: float;
      data: (string * user_data) list;
    }
  | E_define_span of {
      tid: int;
      name: string;
      time_us: float;
      id: span;
      fun_name: string option;
      data: (string * user_data) list;
    }
  | E_exit_span of {
      id: span;
      time_us: float;
    }
  | E_add_data of {
      id: span;
      data: (string * user_data) list;
    }
  | E_enter_manual_span of {
      tid: int;
      name: string;
      time_us: float;
      id: int;
      flavor: [ `Sync | `Async ] option;
      fun_name: string option;
      data: (string * user_data) list;
    }
  | E_exit_manual_span of {
      tid: int;
      name: string;
      time_us: float;
      flavor: [ `Sync | `Async ] option;
      data: (string * user_data) list;
      id: int;
    }
  | E_counter of {
      name: string;
      tid: int;
      time_us: float;
      n: float;
    }
  | E_name_process of { name: string }
  | E_name_thread of {
      tid: int;
      name: string;
    }
