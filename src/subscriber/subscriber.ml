(** A trace subscriber *)
type t =
  | Sub : {
      st: 'st;
      callbacks: 'st Callbacks.t;
    }
      -> t

let dummy : t = Sub { st = (); callbacks = Callbacks.dummy () }

open struct
  module Tee_cb : Callbacks.S with type st = t * t = struct
    type nonrec st = t * t

    let on_init
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns =
      CB1.on_init s1 ~time_ns;
      CB2.on_init s2 ~time_ns

    let on_shutdown
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns =
      CB1.on_shutdown s1 ~time_ns;
      CB2.on_shutdown s2 ~time_ns

    let on_name_thread
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid ~name =
      CB1.on_name_thread s1 ~time_ns ~tid ~name;
      CB2.on_name_thread s2 ~time_ns ~tid ~name

    let on_name_process
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid ~name =
      CB1.on_name_process s1 ~time_ns ~tid ~name;
      CB2.on_name_process s2 ~time_ns ~tid ~name

    let on_enter_span
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~__FUNCTION__ ~__FILE__
        ~__LINE__ ~time_ns ~tid ~data ~name span =
      CB1.on_enter_span s1 ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid ~data
        ~name span;
      CB2.on_enter_span s2 ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid ~data
        ~name span

    let on_exit_span
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid span =
      CB1.on_exit_span s1 ~time_ns ~tid span;
      CB2.on_exit_span s2 ~time_ns ~tid span

    let on_add_data
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~data span =
      CB1.on_add_data s1 ~data span;
      CB2.on_add_data s2 ~data span

    let on_message
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid ~span ~data
        msg =
      CB1.on_message s1 ~time_ns ~tid ~span ~data msg;
      CB2.on_message s2 ~time_ns ~tid ~span ~data msg

    let on_counter
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid ~data ~name
        n =
      CB1.on_counter s1 ~time_ns ~tid ~data ~name n;
      CB2.on_counter s2 ~time_ns ~tid ~data ~name n

    let on_enter_manual_span
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~__FUNCTION__ ~__FILE__
        ~__LINE__ ~time_ns ~tid ~parent ~data ~name ~flavor ~trace_id span =
      CB1.on_enter_manual_span s1 ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns
        ~tid ~parent ~data ~name ~flavor ~trace_id span;
      CB2.on_enter_manual_span s2 ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns
        ~tid ~parent ~data ~name ~flavor ~trace_id span

    let on_exit_manual_span
        ( Sub { st = s1; callbacks = (module CB1) },
          Sub { st = s2; callbacks = (module CB2) } ) ~time_ns ~tid ~name ~data
        ~flavor ~trace_id span =
      CB1.on_exit_manual_span s1 ~time_ns ~tid ~name ~data ~flavor ~trace_id
        span;
      CB2.on_exit_manual_span s2 ~time_ns ~tid ~name ~data ~flavor ~trace_id
        span
  end
end

let tee (s1 : t) (s2 : t) : t =
  let st = s1, s2 in
  Sub { st; callbacks = (module Tee_cb) }
