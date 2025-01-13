(** Callbacks used for subscribers.

  Each subscriber defines a set of callbacks, for each possible
  tracing event. These callbacks take a custom state that is paired
  with the callbacks in {!Subscriber.t}.

  To use a default implementation for some callbacks, use:

  {[
  module My_callbacks = struct
    type st = …

    include Trace_subscriber.Callbacks.Dummy

    let on_init (state:st) ~time_ns : unit = …

    (* … other custom callbacks … *)
  end ]}
*)

open Trace_core
open Types

(** First class module signature for callbacks *)
module type S = sig
  type st
  (** Type of the state passed to every callback. *)

  val on_init : st -> time_ns:float -> unit
  (** Called when the subscriber is initialized in a collector *)

  val on_shutdown : st -> time_ns:float -> unit
  (** Called when the collector is shutdown *)

  val on_name_thread : st -> time_ns:float -> tid:int -> name:string -> unit
  (** Current thread is being named *)

  val on_name_process : st -> time_ns:float -> tid:int -> name:string -> unit
  (** Current process is being named *)

  val on_enter_span :
    st ->
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    time_ns:float ->
    tid:int ->
    data:(string * user_data) list ->
    name:string ->
    span ->
    unit
  (** Enter a regular (sync) span *)

  val on_exit_span : st -> time_ns:float -> tid:int -> span -> unit
  (** Exit a span. This and [on_enter_span] must follow strict stack discipline *)

  val on_add_data : st -> data:(string * user_data) list -> span -> unit
  (** Add data to a regular span (which must be active) *)

  val on_message :
    st ->
    time_ns:float ->
    tid:int ->
    span:span option ->
    data:(string * user_data) list ->
    string ->
    unit
  (** Emit a log message *)

  val on_counter :
    st ->
    time_ns:float ->
    tid:int ->
    data:(string * user_data) list ->
    name:string ->
    float ->
    unit
  (** Emit the current value of a counter *)

  val on_enter_manual_span :
    st ->
    __FUNCTION__:string option ->
    __FILE__:string ->
    __LINE__:int ->
    time_ns:float ->
    tid:int ->
    parent:span option ->
    data:(string * user_data) list ->
    name:string ->
    flavor:flavor option ->
    trace_id:int ->
    span ->
    unit
  (** Enter a manual (possibly async) span *)

  val on_exit_manual_span :
    st ->
    time_ns:float ->
    tid:int ->
    name:string ->
    data:(string * user_data) list ->
    flavor:flavor option ->
    trace_id:int ->
    span ->
    unit
  (** Exit a manual span *)

  val on_extension_event :
    st -> time_ns:float -> tid:int -> extension_event -> unit
  (** Extension event
      @since 0.8 *)
end

type 'st t = (module S with type st = 'st)
(** Callbacks for a subscriber. There is one callback per event
    in {!Trace}. The type ['st] is the state that is passed to
    every single callback. *)

(** Dummy callbacks.
    It can be useful to reuse some of these functions in a
    real subscriber that doesn't want to handle {b all}
    events, but only some of them. *)
module Dummy = struct
  let on_init _ ~time_ns:_ = ()
  let on_shutdown _ ~time_ns:_ = ()
  let on_name_thread _ ~time_ns:_ ~tid:_ ~name:_ = ()
  let on_name_process _ ~time_ns:_ ~tid:_ ~name:_ = ()
  let on_message _ ~time_ns:_ ~tid:_ ~span:_ ~data:_ _msg = ()
  let on_counter _ ~time_ns:_ ~tid:_ ~data:_ ~name:_ _v = ()

  let on_enter_span _ ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~time_ns:_ ~tid:_
      ~data:_ ~name:_ _sp =
    ()

  let on_exit_span _ ~time_ns:_ ~tid:_ _ = ()
  let on_add_data _ ~data:_ _sp = ()

  let on_enter_manual_span _ ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~time_ns:_
      ~tid:_ ~parent:_ ~data:_ ~name:_ ~flavor:_ ~trace_id:_ _sp =
    ()

  let on_exit_manual_span _ ~time_ns:_ ~tid:_ ~name:_ ~data:_ ~flavor:_
      ~trace_id:_ _ =
    ()

  let on_extension_event _ ~time_ns:_ ~tid:_ _ = ()
end

(** Dummy callbacks, ignores all events. *)
let dummy (type st) () : st t =
  let module M = struct
    type nonrec st = st

    include Dummy
  end in
  (module M)
