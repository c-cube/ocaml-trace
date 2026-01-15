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
  type st = t array

  let new_span_id (st : st) =
    let (Sub { st; callbacks = cb }) = Array.get st 0 in
    cb.new_span_id st

  let on_init st ~time_ns =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_init st ~time_ns
    done

  let on_shutdown st ~time_ns =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_shutdown st ~time_ns
    done

  let on_enter_span st span =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_enter_span st span
    done

  let on_exit_span st ~time_ns ~tid span =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_exit_span st ~time_ns ~tid span
    done

  let on_message st ~time_ns ~tid ~span ~params ~data msg =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_message st ~time_ns ~tid ~span ~params ~data msg
    done

  let on_counter st ~time_ns ~tid ~params ~data ~name n =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_counter st ~time_ns ~tid ~params ~data ~name n
    done

  let on_extension_event st ~time_ns ~tid ev : unit =
    for i = 0 to Array.length st - 1 do
      let (Sub { st; callbacks = cb }) = Array.get st i in
      cb.on_extension_event st ~time_ns ~tid ev
    done

  let tee_cb : t array Callbacks.t =
    {
      Callbacks.on_init;
      new_span_id;
      on_enter_span;
      on_exit_span;
      on_message;
      on_counter;
      on_extension_event;
      on_shutdown;
    }
end

(** Tee multiple subscribers, ie return a subscriber that forwards to every
    subscriber in [subs].

    To generate a new span or trace ID, the first subscriber of the list is
    used. *)
let tee_l (subs : t list) : t =
  match subs with
  | [] -> dummy
  | [ s ] -> s
  | l -> Sub { st = Array.of_list l; callbacks = tee_cb }

(** [tee s1 s2] is a subscriber that forwards every call to [s1] and [s2] both.
*)
let tee (s1 : t) (s2 : t) : t = tee_l [ s1; s2 ]
