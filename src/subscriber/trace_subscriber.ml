open Trace_core
module Callbacks = Callbacks
module Subscriber = Subscriber
module Span_tbl = Span_tbl
include Types

type t = Subscriber.t

module Private_ = struct
  let mock = ref false
  let get_now_ns_ = ref Time_.get_time_ns
  let get_tid_ = ref Thread_.get_tid

  (** Now, in nanoseconds *)
  let[@inline] now_ns () : int64 =
    if !mock then
      !get_now_ns_ ()
    else
      Time_.get_time_ns ()

  let[@inline] tid_ () : int =
    if !mock then
      !get_tid_ ()
    else
      Thread_.get_tid ()
end

open struct
  module A = Trace_core.Internal_.Atomic_

  type manual_span_info = {
    name: string;
    flavor: flavor option;
    mutable data: (string * user_data) list;
  }

  (** Key used to carry some information between begin and end of manual spans,
      by way of the meta map *)
  let key_manual_info : manual_span_info Meta_map.key = Meta_map.Key.create ()
end

let[@inline] conv_flavor = function
  | `Async -> Async
  | `Sync -> Sync

let[@inline] conv_flavor_opt = function
  | None -> None
  | Some f -> Some (conv_flavor f)

let[@inline] conv_user_data = function
  | `Int i -> U_int i
  | `Bool b -> U_bool b
  | `Float f -> U_float f
  | `String s -> U_string s
  | `None -> U_none

let rec conv_data = function
  | [] -> []
  | [ (k, v) ] -> [ k, conv_user_data v ]
  | (k, v) :: tl -> (k, conv_user_data v) :: conv_data tl

(** A collector that calls the callbacks of subscriber *)
let collector (Sub { st; callbacks = (module CB) } : Subscriber.t) : collector =
  let open Private_ in
  let module M = struct
    let enter_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name : span =
      let span = CB.new_span st in
      let tid = tid_ () in
      let time_ns = now_ns () in
      let data = conv_data data in
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
      if data <> [] then (
        let data = conv_data data in
        CB.on_add_data st ~data span
      )

    let enter_manual_span ~(parent : explicit_span_ctx option) ~flavor
        ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name : explicit_span =
      let span = CB.new_span st in
      let tid = tid_ () in
      let time_ns = now_ns () in
      let data = conv_data data in
      let flavor = conv_flavor_opt flavor in

      (* get the common trace id, or make a new one *)
      let trace_id, parent =
        match parent with
        | Some m -> m.trace_id, Some m.span
        | None -> CB.new_trace_id st, None
      in

      CB.on_enter_manual_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~parent ~data
        ~time_ns ~tid ~name ~flavor ~trace_id span;
      let meta =
        Meta_map.empty
        |> Meta_map.add key_manual_info { name; flavor; data = [] }
      in
      { span; trace_id; meta }

    let exit_manual_span (es : explicit_span) : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      let trace_id = es.trace_id in
      let minfo =
        match Meta_map.find key_manual_info es.meta with
        | None -> assert false
        | Some m -> m
      in
      CB.on_exit_manual_span st ~tid ~time_ns ~data:minfo.data ~name:minfo.name
        ~flavor:minfo.flavor ~trace_id es.span

    let add_data_to_manual_span (es : explicit_span) data =
      if data <> [] then (
        let data = conv_data data in
        match Meta_map.find key_manual_info es.meta with
        | None -> assert false
        | Some m -> m.data <- List.rev_append data m.data
      )

    let message ?span ~data msg : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      let data = conv_data data in
      CB.on_message st ~time_ns ~tid ~span ~data msg

    let counter_float ~data name f : unit =
      let time_ns = now_ns () in
      let tid = tid_ () in
      let data = conv_data data in
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

    let extension_event ev =
      let tid = tid_ () in
      let time_ns = now_ns () in
      CB.on_extension_event st ~time_ns ~tid ev

    let () =
      (* init code *)
      let time_ns = now_ns () in
      CB.on_init st ~time_ns
  end in
  (module M)

module Span_generator = struct
  type t = int A.t

  let create () = A.make 0
  let[@inline] mk_span self = A.fetch_and_add self 1 |> Int64.of_int
end

module Trace_id_8B_generator = struct
  type t = int A.t

  let create () = A.make 0

  let[@inline] mk_trace_id (self : t) : trace_id =
    let n = A.fetch_and_add self 1 in
    let b = Bytes.create 8 in
    Bytes.set_int64_le b 0 (Int64.of_int n);
    Bytes.unsafe_to_string b
end
