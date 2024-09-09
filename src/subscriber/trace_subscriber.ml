open Trace_core
module Callbacks = Callbacks
module Subscriber = Subscriber

type t = Subscriber.t

module Private_ = struct
  let get_now_ns_ = ref None
  let get_tid_ = ref None

  (** Now, in nanoseconds *)
  let[@inline] now_ns () : float =
    match !get_now_ns_ with
    | Some f -> f ()
    | None ->
      let t = Mtime_clock.now () in
      Int64.to_float (Mtime.to_uint64_ns t)

  let[@inline] tid_ () : int =
    match !get_tid_ with
    | Some f -> f ()
    | None -> Thread.id (Thread.self ())
end

open struct
  module A = Trace_core.Internal_.Atomic_

  type manual_span_info = {
    name: string;
    flavor: [ `Sync | `Async ] option;
    mutable data: (string * user_data) list;
  }

  (** Key used to carry some information between begin and end of
    manual spans, by way of the meta map *)
  let key_manual_info : manual_span_info Meta_map.key = Meta_map.Key.create ()

  (** key used to carry a unique "id" for all spans in an async context *)
  let key_async_trace_id : int Meta_map.key = Meta_map.Key.create ()
end

(** A collector that calls the callbacks of subscriber *)
let collector (Sub { st; callbacks = (module CB) } : Subscriber.t) : collector =
  let open Private_ in
  let module M = struct
    let trace_id_gen_ = A.make 0

    (** generator for span ids *)
    let new_span_ : unit -> int =
      let span_id_gen_ = A.make 0 in
      fun [@inline] () -> A.fetch_and_add span_id_gen_ 1

    let enter_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name : span =
      let span = Int64.of_int (new_span_ ()) in
      let tid = tid_ () in
      let time_ns = now_ns () in
      CB.on_enter_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~time_ns ~tid ~data
        ~name span;
      span

    let exit_span span : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      CB.on_exit_span st ~time_ns ~tid span

    let with_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name f =
      let span = enter_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name in
      try
        let x = f span in
        exit_span span;
        x
      with exn ->
        let bt = Printexc.get_raw_backtrace () in
        exit_span span;
        Printexc.raise_with_backtrace exn bt

    let add_data_to_span span data =
      if data <> [] then CB.on_add_data st ~data span

    let enter_manual_span ~(parent : explicit_span option) ~flavor ~__FUNCTION__
        ~__FILE__ ~__LINE__ ~data name : explicit_span =
      let span = Int64.of_int (new_span_ ()) in
      let tid = tid_ () in
      let time_ns = now_ns () in

      (* get the common trace id, or make a new one *)
      let trace_id =
        match parent with
        | Some m -> Meta_map.find_exn key_async_trace_id m.meta
        | None -> A.fetch_and_add trace_id_gen_ 1
      in

      CB.on_enter_manual_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~parent ~data
        ~time_ns ~tid ~name ~flavor ~trace_id span;
      let meta =
        Meta_map.empty
        |> Meta_map.add key_manual_info { name; flavor; data = [] }
        |> Meta_map.add key_async_trace_id trace_id
      in
      { span; meta }

    let exit_manual_span (es : explicit_span) : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      let trace_id =
        match Meta_map.find key_async_trace_id es.meta with
        | None -> assert false
        | Some id -> id
      in
      let minfo =
        match Meta_map.find key_manual_info es.meta with
        | None -> assert false
        | Some m -> m
      in
      CB.on_exit_manual_span st ~tid ~time_ns ~data:minfo.data ~name:minfo.name
        ~flavor:minfo.flavor ~trace_id es.span

    let add_data_to_manual_span (es : explicit_span) data =
      if data <> [] then (
        match Meta_map.find key_manual_info es.meta with
        | None -> assert false
        | Some m -> m.data <- List.rev_append data m.data
      )

    let message ?span ~data msg : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      CB.on_message st ~time_ns ~tid ~span ~data msg

    let counter_float ~data name f : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      CB.on_counter st ~tid ~time_ns ~data ~name f

    let[@inline] counter_int ~data name i =
      counter_float ~data name (float_of_int i)

    let name_process name : unit =
      let tid = tid_ () in
      let time_ns = now_ns () in
      CB.on_name_process st ~time_ns ~tid ~name

    let name_thread name : unit =
      let tid = tid_ () in
      let time_ns = now_ns () in
      CB.on_name_thread st ~time_ns ~tid ~name

    let shutdown () =
      let time_ns = now_ns () in
      CB.on_shutdown st ~time_ns

    let () =
      (* init code *)
      let time_ns = now_ns () in
      CB.on_init st ~time_ns
  end in
  (module M)
