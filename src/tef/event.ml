open Trace_core
module Sub = Trace_subscriber

(** An event, specialized for TEF *)
type t =
  | E_tick
  | E_message of {
      tid: int;
      msg: string;
      time_us: float;
      data: (string * Sub.user_data) list;
    }
  | E_define_span of {
      tid: int;
      name: string;
      time_us: float;
      id: span;
      fun_name: string option;
      data: (string * Sub.user_data) list;
    }
  | E_exit_span of {
      id: span;
      time_us: float;
    }
  | E_add_data of {
      id: span;
      data: (string * Sub.user_data) list;
    }
  | E_enter_manual_span of {
      tid: int;
      name: string;
      time_us: float;
      id: trace_id;
      flavor: Sub.flavor option;
      fun_name: string option;
      data: (string * Sub.user_data) list;
    }
  | E_exit_manual_span of {
      tid: int;
      name: string;
      time_us: float;
      flavor: Sub.flavor option;
      data: (string * Sub.user_data) list;
      id: trace_id;
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
