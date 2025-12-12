(** Trace subscribers *)

(** A trace subscriber. It pairs a set of callbacks with the state they need
    (which can contain a file handle, a socket to write events to, config,
    etc.).

    The design goal for this is that it should be possible to avoid allocations
    whenever the trace collector invokes the callbacks. *)
type t =
  | Sub : {
      st: 'st;
      callbacks: 'st Callbacks.t;
    }
      -> t

(** Dummy subscriber that ignores every call. *)
let dummy : t = Sub { st = (); callbacks = Callbacks.dummy () }

open struct
  module Tee_cb : Callbacks.S with type st = t array = struct
    type nonrec st = t array

    let new_span st =
      let (Sub { st = s; callbacks = (module CB) }) = Array.get st 0 in
      CB.new_span s

    let new_explicit_span st =
      let (Sub { st = s; callbacks = (module CB) }) = Array.get st 0 in
      CB.new_explicit_span s

    let on_init st ~time_ns =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_init s ~time_ns
      done

    let on_shutdown st ~time_ns =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_shutdown s ~time_ns
      done

    let on_name_thread st ~time_ns ~tid ~name =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_name_thread s ~time_ns ~tid ~name
      done

    let on_name_process st ~time_ns ~tid ~name =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_name_process s ~time_ns ~tid ~name
      done

    let on_enter_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid ~data
        ~name span =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_enter_span s ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid ~data
          ~name span
      done

    let on_exit_span st ~time_ns ~tid span =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_exit_span s ~time_ns ~tid span
      done

    let on_add_data st ~data span =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_add_data s ~data span
      done

    let on_message st ~time_ns ~tid ~span ~data msg =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_message s ~time_ns ~tid ~span ~data msg
      done

    let on_counter st ~time_ns ~tid ~data ~name n =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_counter s ~time_ns ~tid ~data ~name n
      done

    let on_enter_manual_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid
        ~parent ~data ~name ~flavor span =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_enter_manual_span s ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns
          ~tid ~parent ~data ~name ~flavor span
      done

    let on_exit_manual_span st ~time_ns ~tid ~name ~data ~flavor span =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_exit_manual_span s ~time_ns ~tid ~name ~data ~flavor span
      done

    let on_extension_event st ~time_ns ~tid ev : unit =
      for i = 0 to Array.length st - 1 do
        let (Sub { st = s; callbacks = (module CB) }) = Array.get st i in
        CB.on_extension_event s ~time_ns ~tid ev
      done
  end
end

(** Tee multiple subscribers, ie return a subscriber that forwards to every
    subscriber in [subs].

    To generate a new span or trace ID, the first subscriber of the list is
    used. *)
let tee_l (subs : t list) : t =
  match subs with
  | [] -> dummy
  | [ s ] -> s
  | l -> Sub { st = Array.of_list l; callbacks = (module Tee_cb) }

(** [tee s1 s2] is a subscriber that forwards every call to [s1] and [s2] both.
*)
let tee (s1 : t) (s2 : t) : t = tee_l [ s1; s2 ]
