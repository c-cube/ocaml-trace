open Trace_core
open Trace_private_util
open Event
module Sub = Trace_subscriber
module A = Trace_core.Internal_.Atomic_

let on_tracing_error = ref (fun s -> Printf.eprintf "trace-tef error: %s\n%!" s)

let[@inline] int64_of_trace_id_ (id : Trace_core.trace_id) : int64 =
  if id == Trace_core.Collector.dummy_trace_id then
    0L
  else
    Bytes.get_int64_le (Bytes.unsafe_of_string id) 0

module Mock_ = struct
  let enabled = ref false
  let now = ref 0

  (* used to mock timing *)
  let get_now_ns () : float =
    let x = !now in
    incr now;
    float_of_int x *. 1000.

  let get_tid_ () : int = 3
end

module Span_tbl = Hashtbl.Make (struct
  include Int64

  let hash : t -> int = Hashtbl.hash
end)

type span_info = {
  tid: int;
  name: string;
  start_us: float;
  mutable data: (string * Sub.user_data) list;
}

(** Writer: knows how to write entries to a file in TEF format *)
module Writer = struct
  type t = {
    oc: out_channel;
    jsonl: bool;  (** JSONL mode, one json event per line *)
    mutable first: bool;  (** first event? useful in json mode *)
    buf: Buffer.t;  (** Buffer to write into *)
    must_close: bool;  (** Do we have to close the underlying channel [oc]? *)
    pid: int;
  }
  (** A writer to a [out_channel]. It writes JSON entries in an array and closes
      the array at the end. *)

  let create ~(mode : [ `Single | `Jsonl ]) ~out () : t =
    let jsonl = mode = `Jsonl in
    let oc, must_close =
      match out with
      | `Stdout -> stdout, false
      | `Stderr -> stderr, false
      | `File path -> open_out path, true
      | `File_append path ->
        open_out_gen [ Open_creat; Open_wronly; Open_append ] 0o644 path, true
      | `Output oc -> oc, false
    in
    let pid =
      if !Mock_.enabled then
        2
      else
        Unix.getpid ()
    in
    if not jsonl then output_char oc '[';
    { oc; jsonl; first = true; pid; must_close; buf = Buffer.create 2_048 }

  let close (self : t) : unit =
    if self.jsonl then
      output_char self.oc '\n'
    else
      output_char self.oc ']';
    flush self.oc;
    if self.must_close then close_out self.oc

  let with_ ~mode ~out f =
    let writer = create ~mode ~out () in
    Fun.protect ~finally:(fun () -> close writer) (fun () -> f writer)

  let[@inline] flush (self : t) : unit = flush self.oc

  (** Emit "," if we need, and get the buffer ready *)
  let emit_sep_and_start_ (self : t) =
    Buffer.reset self.buf;
    if self.jsonl then
      Buffer.add_char self.buf '\n'
    else if self.first then
      self.first <- false
    else
      Buffer.add_string self.buf ",\n"

  let char = Buffer.add_char
  let raw_string = Buffer.add_string

  let str_val (buf : Buffer.t) (s : string) =
    char buf '"';
    let encode_char c =
      match c with
      | '"' -> raw_string buf {|\"|}
      | '\\' -> raw_string buf {|\\|}
      | '\n' -> raw_string buf {|\n|}
      | '\b' -> raw_string buf {|\b|}
      | '\r' -> raw_string buf {|\r|}
      | '\t' -> raw_string buf {|\t|}
      | _ when Char.code c <= 0x1f ->
        raw_string buf {|\u00|};
        Printf.bprintf buf "%02x" (Char.code c)
      | c -> char buf c
    in
    String.iter encode_char s;
    char buf '"'

  let pp_user_data_ (out : Buffer.t) : Sub.user_data -> unit = function
    | U_none -> raw_string out "null"
    | U_int i -> Printf.bprintf out "%d" i
    | U_bool b -> Printf.bprintf out "%b" b
    | U_string s -> str_val out s
    | U_float f -> Printf.bprintf out "%g" f

  (* emit args, if not empty. [ppv] is used to print values. *)
  let emit_args_o_ ppv (out : Buffer.t) args : unit =
    if args <> [] then (
      Printf.bprintf out {json|,"args": {|json};
      List.iteri
        (fun i (n, value) ->
          if i > 0 then raw_string out ",";
          Printf.bprintf out {json|"%s":%a|json} n ppv value)
        args;
      char out '}'
    )

  let emit_duration_event ~tid ~name ~start ~end_ ~args (self : t) : unit =
    let dur = end_ -. start in
    let ts = start in

    emit_sep_and_start_ self;

    Printf.bprintf self.buf
      {json|{"pid":%d,"cat":"","tid": %d,"dur": %.2f,"ts": %.2f,"name":%a,"ph":"X"%a}|json}
      self.pid tid dur ts str_val name
      (emit_args_o_ pp_user_data_)
      args;
    Buffer.output_buffer self.oc self.buf

  let emit_manual_begin ~tid ~name ~(id : trace_id) ~ts ~args
      ~(flavor : Sub.flavor option) (self : t) : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"cat":"trace","id":%Ld,"tid": %d,"ts": %.2f,"name":%a,"ph":"%c"%a}|json}
      self.pid (int64_of_trace_id_ id) tid ts str_val name
      (match flavor with
      | None | Some Async -> 'b'
      | Some Sync -> 'B')
      (emit_args_o_ pp_user_data_)
      args;
    Buffer.output_buffer self.oc self.buf

  let emit_manual_end ~tid ~name ~(id : trace_id) ~ts
      ~(flavor : Sub.flavor option) ~args (self : t) : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"cat":"trace","id":%Ld,"tid": %d,"ts": %.2f,"name":%a,"ph":"%c"%a}|json}
      self.pid (int64_of_trace_id_ id) tid ts str_val name
      (match flavor with
      | None | Some Async -> 'e'
      | Some Sync -> 'E')
      (emit_args_o_ pp_user_data_)
      args;
    Buffer.output_buffer self.oc self.buf

  let emit_instant_event ~tid ~name ~ts ~args (self : t) : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"cat":"","tid": %d,"ts": %.2f,"name":%a,"ph":"I"%a}|json}
      self.pid tid ts str_val name
      (emit_args_o_ pp_user_data_)
      args;
    Buffer.output_buffer self.oc self.buf

  let emit_name_thread ~tid ~name (self : t) : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"tid": %d,"name":"thread_name","ph":"M"%a}|json} self.pid
      tid
      (emit_args_o_ pp_user_data_)
      [ "name", U_string name ];
    Buffer.output_buffer self.oc self.buf

  let emit_name_process ~name (self : t) : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"name":"process_name","ph":"M"%a}|json} self.pid
      (emit_args_o_ pp_user_data_)
      [ "name", U_string name ];
    Buffer.output_buffer self.oc self.buf

  let emit_counter ~name ~tid ~ts (self : t) f : unit =
    emit_sep_and_start_ self;
    Printf.bprintf self.buf
      {json|{"pid":%d,"tid":%d,"ts":%.2f,"name":"c","ph":"C"%a}|json} self.pid
      tid ts
      (emit_args_o_ pp_user_data_)
      [ name, U_float f ];
    Buffer.output_buffer self.oc self.buf
end

let block_signals () =
  try
    ignore
      (Unix.sigprocmask SIG_BLOCK
         [
           Sys.sigterm;
           Sys.sigpipe;
           Sys.sigint;
           Sys.sigchld;
           Sys.sigalrm;
           Sys.sigusr1;
           Sys.sigusr2;
         ]
        : _ list)
  with _ -> ()

let print_non_closed_spans_warning spans =
  let module Str_set = Set.Make (String) in
  Printf.eprintf "trace-tef: warning: %d spans were not closed\n"
    (Span_tbl.length spans);
  let names = ref Str_set.empty in
  Span_tbl.iter (fun _ span -> names := Str_set.add span.name !names) spans;
  Str_set.iter
    (fun name -> Printf.eprintf "  span %S was not closed\n" name)
    !names;
  flush stderr

(** Background thread, takes events from the queue, puts them in context using
    local state, and writes fully resolved TEF events to [out]. *)
let bg_thread ~mode ~out (events : Event.t B_queue.t) : unit =
  block_signals ();

  (* open a writer to [out] *)
  Writer.with_ ~mode ~out @@ fun writer ->
  (* local state, to keep track of span information and implicit stack context *)
  let spans : span_info Span_tbl.t = Span_tbl.create 32 in

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", Sub.U_string f) :: data
  in

  (* how to deal with an event *)
  let handle_ev (ev : Event.t) : unit =
    match ev with
    | E_tick -> Writer.flush writer
    | E_message { tid; msg; time_us; data } ->
      Writer.emit_instant_event ~tid ~name:msg ~ts:time_us ~args:data writer
    | E_define_span { tid; name; id; time_us; fun_name; data } ->
      let data = add_fun_name_ fun_name data in
      let info = { tid; name; start_us = time_us; data } in
      (* save the span so we find it at exit *)
      Span_tbl.add spans id info
    | E_exit_span { id; time_us = stop_us } ->
      (match Span_tbl.find_opt spans id with
      | None -> !on_tracing_error (Printf.sprintf "cannot find span %Ld" id)
      | Some { tid; name; start_us; data } ->
        Span_tbl.remove spans id;
        Writer.emit_duration_event ~tid ~name ~start:start_us ~end_:stop_us
          ~args:data writer)
    | E_add_data { id; data } ->
      (match Span_tbl.find_opt spans id with
      | None -> !on_tracing_error (Printf.sprintf "cannot find span %Ld" id)
      | Some info -> info.data <- List.rev_append data info.data)
    | E_enter_manual_span { tid; time_us; name; id; data; fun_name; flavor } ->
      let data = add_fun_name_ fun_name data in
      Writer.emit_manual_begin ~tid ~name ~id ~ts:time_us ~args:data ~flavor
        writer
    | E_exit_manual_span { tid; time_us; name; id; flavor; data } ->
      Writer.emit_manual_end ~tid ~name ~id ~ts:time_us ~flavor ~args:data
        writer
    | E_counter { tid; name; time_us; n } ->
      Writer.emit_counter ~name ~tid ~ts:time_us writer n
    | E_name_process { name } -> Writer.emit_name_process ~name writer
    | E_name_thread { tid; name } -> Writer.emit_name_thread ~tid ~name writer
  in

  try
    while true do
      (* get all the events in the incoming blocking queue, in
         one single critical section. *)
      let local = B_queue.pop_all events in
      List.iter handle_ev local
    done
  with B_queue.Closed ->
    (* write a message about us closing *)
    Writer.emit_instant_event ~name:"tef-worker.exit"
      ~tid:(Thread.id @@ Thread.self ())
      ~ts:(Sub.Private_.now_ns () *. 1e-3)
      ~args:[] writer;

    (* warn if app didn't close all spans *)
    if Span_tbl.length spans > 0 then print_non_closed_spans_warning spans;
    ()

(** Thread that simply regularly "ticks", sending events to the background
    thread so it has a chance to write to the file *)
let tick_thread events : unit =
  block_signals ();
  try
    while true do
      Thread.delay 0.5;
      B_queue.push events E_tick
    done
  with B_queue.Closed -> ()

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

module Internal_st = struct
  type t = {
    active: bool A.t;
    events: Event.t B_queue.t;
    t_write: Thread.t;
  }
end

let subscriber_ ~finally ~out ~(mode : [ `Single | `Jsonl ]) () : Sub.t =
  let module M : Sub.Callbacks.S with type st = Internal_st.t = struct
    type st = Internal_st.t

    let on_init _ ~time_ns:_ = ()

    let on_shutdown (self : st) ~time_ns:_ =
      if A.exchange self.active false then (
        B_queue.close self.events;
        (* wait for writer thread to be done. The writer thread will exit
           after processing remaining events because the queue is now closed *)
        Thread.join self.t_write
      )

    let on_name_process (self : st) ~time_ns:_ ~tid:_ ~name : unit =
      B_queue.push self.events @@ E_name_process { name }

    let on_name_thread (self : st) ~time_ns:_ ~tid ~name : unit =
      B_queue.push self.events @@ E_name_thread { tid; name }

    let[@inline] on_enter_span (self : st) ~__FUNCTION__:fun_name ~__FILE__:_
        ~__LINE__:_ ~time_ns ~tid ~data ~name span : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events
      @@ E_define_span { tid; name; time_us; id = span; fun_name; data }

    let on_exit_span (self : st) ~time_ns ~tid:_ span : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events @@ E_exit_span { id = span; time_us }

    let on_add_data (self : st) ~data span =
      if data <> [] then
        B_queue.push self.events @@ E_add_data { id = span; data }

    let on_message (self : st) ~time_ns ~tid ~span:_ ~data msg : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events @@ E_message { tid; time_us; msg; data }

    let on_counter (self : st) ~time_ns ~tid ~data:_ ~name f : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events @@ E_counter { name; n = f; time_us; tid }

    let on_enter_manual_span (self : st) ~__FUNCTION__:fun_name ~__FILE__:_
        ~__LINE__:_ ~time_ns ~tid ~parent:_ ~data ~name ~flavor ~trace_id _span
        : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events
      @@ E_enter_manual_span
           { id = trace_id; time_us; tid; data; name; fun_name; flavor }

    let on_exit_manual_span (self : st) ~time_ns ~tid ~name ~data ~flavor
        ~trace_id (_ : span) : unit =
      let time_us = time_ns *. 1e-3 in
      B_queue.push self.events
      @@ E_exit_manual_span { tid; id = trace_id; name; time_us; data; flavor }

    let on_extension_event _ ~time_ns:_ ~tid:_ _ev = ()
  end in
  let events = B_queue.create () in
  let t_write =
    Thread.create
      (fun () -> Fun.protect ~finally @@ fun () -> bg_thread ~mode ~out events)
      ()
  in

  (* ticker thread, regularly sends a message to the writer thread.
      no need to join it. *)
  let _t_tick : Thread.t = Thread.create (fun () -> tick_thread events) () in
  let st : Internal_st.t = { active = A.make true; events; t_write } in
  Sub.Subscriber.Sub { st; callbacks = (module M) }

let collector_ ~(finally : unit -> unit) ~(mode : [ `Single | `Jsonl ]) ~out ()
    : collector =
  let sub = subscriber_ ~finally ~mode ~out () in
  Sub.collector sub

let[@inline] subscriber ~out () : Sub.t =
  subscriber_ ~finally:ignore ~mode:`Single ~out ()

let[@inline] collector ~out () : collector =
  collector_ ~finally:ignore ~mode:`Single ~out ()

let setup ?(out = `Env) () =
  match out with
  | `Stderr -> Trace_core.setup_collector @@ collector ~out:`Stderr ()
  | `Stdout -> Trace_core.setup_collector @@ collector ~out:`Stdout ()
  | `File path -> Trace_core.setup_collector @@ collector ~out:(`File path) ()
  | `Env ->
    (match Sys.getenv_opt "TRACE" with
    | Some ("1" | "true") ->
      let path = "trace.json" in
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | Some "stdout" -> Trace_core.setup_collector @@ collector ~out:`Stdout ()
    | Some "stderr" -> Trace_core.setup_collector @@ collector ~out:`Stderr ()
    | Some path ->
      let c = collector ~out:(`File path) () in
      Trace_core.setup_collector c
    | None -> ())

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Private_ = struct
  let mock_all_ () =
    Mock_.enabled := true;
    Sub.Private_.get_now_ns_ := Some Mock_.get_now_ns;
    Sub.Private_.get_tid_ := Some Mock_.get_tid_;
    ()

  let on_tracing_error = on_tracing_error

  let subscriber_jsonl ~finally ~out () =
    subscriber_ ~finally ~mode:`Jsonl ~out ()

  let collector_jsonl ~finally ~out () : collector =
    collector_ ~finally ~mode:`Jsonl ~out ()

  module Event = Event
end
