open Common_
open Trace_core
module Sub = Trace_subscriber
module Span_tbl = Sub.Span_tbl
module J = Yojson.Safe

(* *)
module USDT = Ocaml_usdt
module USDT_J = Usdt_json

open struct
  let[@inline] time_us_of_time_ns (t : int64) : float =
    Int64.div t 1_000L |> Int64.to_float
end

let on_tracing_error = ref (fun s -> Printf.eprintf "%s\n%!" s)

module Types = struct
  type span_info = {
    tid: int;
    name: string;
    start_us: float;
    mutable dur_us: float;
    mutable data: (string * Sub.user_data) list;
        (* NOTE: thread safety: this is supposed to only be modified by the thread
        that's running this (synchronous, stack-abiding) span. *)
  }
  (** Information we store about a span begin event, to emit a complete event
      when we meet the corresponding span end event *)

  type message = {
    msg: string;
    time_us: float;
    data: (string * Sub.user_data) list;
  }

  type counter = {
    name: string;
    c: float;
    time_us: float;
  }

  let yojson_of_user_data (d : Sub.user_data) : J.t =
    match d with
    | U_bool b -> `Bool b
    | U_float f -> `Float f
    | U_int i -> `Int i
    | U_none -> `Null
    | Sub.U_string s -> `String s

  let yojson_of_data l =
    `Assoc (List.map (fun (k, v) -> k, yojson_of_user_data v) l)

  let add_data_ data alist =
    if data = [] then
      alist
    else
      ("data", yojson_of_data data) :: alist

  let yojson_of_span (sp : span_info) : J.t =
    let { tid; name; start_us; dur_us; data } = sp in
    let alist =
      [ "name", `String name; "tid", `Int tid; "start_us", `Float start_us ]
    in
    let l =
      if dur_us < 0. then
        alist
      else
        ("dur_us", `Float dur_us) :: alist
    in
    let alist = add_data_ data l in
    `Assoc alist

  let yojson_of_message (m : message) : J.t =
    let { msg; time_us; data } = m in
    let alist =
      [ "time_us", `Float time_us; "msg", `String msg ] |> add_data_ data
    in
    `Assoc alist

  let yojson_of_counter (c : counter) : J.t =
    let { name; c; time_us } = c in
    let alist =
      [ "name", `String name; "time_us", `Float time_us; "c", `Float c ]
    in
    `Assoc alist
end

type t = {
  active: bool A.t;
  spans: Types.span_info Span_tbl.t;
}

let close (self : t) : unit = if A.exchange self.active false then ()
let[@inline] active self = A.get self.active
let create () : t = { active = A.make true; spans = Span_tbl.create () }

open struct
  let probe_name_thread = USDT.register "otrace:tname"
  let probe_enter = USDT_J.make_probe Types.yojson_of_span "otrace:enter"
  let probe_exit = USDT_J.make_probe Types.yojson_of_span "otrace:exit"
  let probe_msg = USDT_J.make_probe Types.yojson_of_message "otrace:msg"
  let probe_counter = USDT_J.make_probe Types.yojson_of_counter "otrace:count"
end

module Callbacks = struct
  type st = t

  let on_init _ ~time_ns:_ = ()
  let on_shutdown (self : st) ~time_ns:_ = close self

  let on_name_process (_self : st) ~time_ns:_ ~tid:_ ~name : unit =
    USDT.set_provider name

  let on_name_thread (_self : st) ~time_ns:_ ~tid ~name : unit =
    USDT.fire_lazy probe_name_thread (fun () -> [ I tid; S name ])

  let on_enter_span (self : st) ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~time_ns
      ~tid ~data ~name span : unit =
    let time_us = time_us_of_time_ns @@ time_ns in
    let info : Types.span_info =
      { tid; name; start_us = time_us; dur_us = -1.; data }
    in
    (* save the span so we find it at exit *)
    Span_tbl.add self.spans span info;
    probe_enter info

  let on_exit_span (self : st) ~time_ns ~tid:_ span : unit =
    let time_us = time_us_of_time_ns @@ time_ns in

    match Span_tbl.find_exn self.spans span with
    | exception Not_found ->
      !on_tracing_error
        (Printf.sprintf "trace-tef: error: cannot find span %Ld" span)
    | info ->
      Span_tbl.remove self.spans span;
      (* compute duration *)
      info.dur_us <- time_us -. info.start_us;
      probe_exit info

  let on_add_data (self : st) ~data span =
    if data <> [] then (
      try
        let info = Span_tbl.find_exn self.spans span in
        info.data <- List.rev_append data info.data
      with Not_found ->
        !on_tracing_error
          (Printf.sprintf "trace-tef: error: cannot find span %Ld" span)
    )

  let on_message (_self : st) ~time_ns ~tid:_ ~span:_ ~data msg : unit =
    let time_us = time_us_of_time_ns @@ time_ns in
    probe_msg { time_us; msg; data }

  let on_counter (_self : st) ~time_ns ~tid:_ ~data:_ ~name n : unit =
    let time_us = time_us_of_time_ns @@ time_ns in
    probe_counter { name; c = n; time_us }

  [@@@ocaml.warning "-27"]

  let on_enter_manual_span (_self : st) ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_
      ~time_ns ~tid ~parent:_ ~data ~name ~flavor ~trace_id _span : unit =
    ()
  (* TODO:
    let time_us = time_us_of_time_ns @@ time_ns in

    let data = add_fun_name_ fun_name data in
    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_manual_begin buf ~pid:self.pid ~tid ~name
      ~id:(int64_of_trace_id_ trace_id)
      ~ts:time_us ~args:data ~flavor;
    self.exporter.on_json buf
    *)

  let on_exit_manual_span (self : st) ~time_ns ~tid ~name ~data ~flavor
      ~trace_id (_ : span) : unit =
    ()
  (* TODO:
    let time_us = time_us_of_time_ns @@ time_ns in

    let@ buf = Rpool.with_ self.buf_pool in
    Writer.emit_manual_end buf ~pid:self.pid ~tid ~name
      ~id:(int64_of_trace_id_ trace_id)
      ~ts:time_us ~flavor ~args:data;
    self.exporter.on_json buf
    *)

  [@@@ocaml.warning "+27"]

  let on_extension_event _ ~time_ns:_ ~tid:_ _ev = ()
end

let subscriber (self : t) : Sub.t =
  Sub.Subscriber.Sub { st = self; callbacks = (module Callbacks) }
