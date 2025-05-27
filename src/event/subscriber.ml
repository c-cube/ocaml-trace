(** Subscriber that emits events *)

open Trace_core
open Event

type event_consumer = { on_event: Event.t -> unit } [@@unboxed]
(** Callback for events. *)

module Callbacks : Sub.Callbacks.S with type st = event_consumer = struct
  type st = event_consumer

  let on_init (self : st) ~time_ns = self.on_event (E_init { time_ns })
  let on_shutdown (self : st) ~time_ns = self.on_event (E_shutdown { time_ns })

  let on_name_process (self : st) ~time_ns:_ ~tid:_ ~name : unit =
    self.on_event @@ E_name_process { name }

  let on_name_thread (self : st) ~time_ns:_ ~tid ~name : unit =
    self.on_event @@ E_name_thread { tid; name }

  let[@inline] on_enter_span (self : st) ~__FUNCTION__:fun_name ~__FILE__:_
      ~__LINE__:_ ~time_ns ~tid ~data ~name span : unit =
    self.on_event
    @@ E_define_span { tid; name; time_ns; id = span; fun_name; data }

  let on_exit_span (self : st) ~time_ns ~tid:_ span : unit =
    self.on_event @@ E_exit_span { id = span; time_ns }

  let on_add_data (self : st) ~data span =
    if data <> [] then self.on_event @@ E_add_data { id = span; data }

  let on_message (self : st) ~time_ns ~tid ~span:_ ~data msg : unit =
    self.on_event @@ E_message { tid; time_ns; msg; data }

  let on_counter (self : st) ~time_ns ~tid ~data:_ ~name f : unit =
    self.on_event @@ E_counter { name; n = f; time_ns; tid }

  let on_enter_manual_span (self : st) ~__FUNCTION__:fun_name ~__FILE__:_
      ~__LINE__:_ ~time_ns ~tid ~parent:_ ~data ~name ~flavor ~trace_id _span :
      unit =
    self.on_event
    @@ E_enter_manual_span
         { id = trace_id; time_ns; tid; data; name; fun_name; flavor }

  let on_exit_manual_span (self : st) ~time_ns ~tid ~name ~data ~flavor
      ~trace_id (_ : span) : unit =
    self.on_event
    @@ E_exit_manual_span { tid; id = trace_id; name; time_ns; data; flavor }

  let on_extension_event (self : st) ~time_ns ~tid ext : unit =
    self.on_event @@ E_extension_event { tid; time_ns; ext }
end

(** A subscriber that turns calls into events that are passed to the
    {! event_consumer} *)
let subscriber (consumer : event_consumer) : Sub.t =
  Sub.Subscriber.Sub { st = consumer; callbacks = (module Callbacks) }
