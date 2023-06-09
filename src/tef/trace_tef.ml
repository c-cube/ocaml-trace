open Trace
module A = Trace.Internal_.Atomic_

module Mock_ = struct
  let enabled = ref false
  let now = ref 0

  let[@inline never] now_us () : float =
    let x = !now in
    incr now;
    float_of_int x
end

let counter = Mtime_clock.counter ()

(** Now, in microseconds *)
let[@inline] now_us () : float =
  if !Mock_.enabled then
    Mock_.now_us ()
  else (
    let t = Mtime_clock.count counter in
    Mtime.Span.to_float_ns t /. 1e3
  )

let protect ~finally f =
  try
    let x = f () in
    finally ();
    x
  with exn ->
    let bt = Printexc.get_raw_backtrace () in
    finally ();
    Printexc.raise_with_backtrace exn bt

type event =
  | E_message of {
      (*
      __FUNCTION__: string;
      __FILE__: string;
      __LINE__: int;
      *)
      tid: int;
      msg: string;
      time_us: float;
      data: (string * user_data) list;
    }
  | E_define_span of {
      (*
      __FUNCTION__: string;
      __FILE__: string;
      __LINE__: int;
      *)
      tid: int;
      name: string;
      time_us: float;
      id: span;
      data: (string * user_data) list;
    }
  | E_exit_span of {
      id: span;
      time_us: float;
    }
  | E_name_process of { name: string }
  | E_name_thread of {
      tid: int;
      name: string;
    }

module Span_tbl = Hashtbl.Make (struct
  include Int64

  let hash : t -> int = Hashtbl.hash
end)

type span_info = {
  (*
  __FUNCTION__: string;
  __FILE__: string;
  __LINE__: int;
  *)
  tid: int;
  name: string;
  start_us: float;
  data: (string * user_data) list;
}

module Writer = struct
  type t = {
    oc: out_channel;
    mutable first: bool;  (** first event? *)
    must_close: bool;
    pid: int;
  }

  let create ~out () : t =
    let oc, must_close =
      match out with
      | `Stdout -> stdout, false
      | `Stderr -> stderr, false
      | `File path -> open_out path, true
    in
    let pid =
      if !Mock_.enabled then
        2
      else
        Unix.getpid ()
    in
    output_char oc '[';
    { oc; first = true; pid; must_close }

  let close (self : t) : unit =
    output_char self.oc ']';
    flush self.oc;
    if self.must_close then close_out self.oc

  let emit_sep_ (self : t) =
    if self.first then
      self.first <- false
    else
      output_string self.oc ",\n"

  let char = output_char
  let raw_string = output_string

  let str_val oc (s : string) =
    char oc '"';
    let encode_char c =
      match c with
      | '"' -> raw_string oc {|\"|}
      | '\\' -> raw_string oc {|\\|}
      | '\n' -> raw_string oc {|\n|}
      | '\b' -> raw_string oc {|\b|}
      | '\r' -> raw_string oc {|\r|}
      | '\t' -> raw_string oc {|\t|}
      | _ when Char.code c <= 0x1f ->
        raw_string oc {|\u00|};
        Printf.fprintf oc "%02x" (Char.code c)
      | c -> char oc c
    in
    String.iter encode_char s;
    char oc '"'

  let pp_user_data_ out : user_data -> unit = function
    | `None -> Printf.fprintf out "null"
    | `Int i -> Printf.fprintf out "%d" i
    | `Bool b -> Printf.fprintf out "%b" b
    | `String s -> str_val out s

  (* emit args, if not empty. [ppv] is used to print values. *)
  let emit_args_o_ ppv oc args : unit =
    if args <> [] then (
      Printf.fprintf oc {json|,"args": {|json};
      List.iteri
        (fun i (n, value) ->
          if i > 0 then Printf.fprintf oc ",";
          Printf.fprintf oc {json|"%s":%a|json} n ppv value)
        args;
      char oc '}'
    )

  let emit_duration_event ~tid ~name ~start ~end_ ~args (self : t) : unit =
    let dur = end_ -. start in
    let ts = start in
    emit_sep_ self;
    Printf.fprintf self.oc
      {json|{"pid": %d,"cat":"","tid": %d,"dur": %.2f,"ts": %.2f,"name":%a,"ph":"X"%a}|json}
      self.pid tid dur ts str_val name
      (emit_args_o_ pp_user_data_)
      args;
    ()

  let emit_instant_event ~tid ~name ~ts ~args (self : t) : unit =
    emit_sep_ self;
    Printf.fprintf self.oc
      {json|{"pid": %d,"cat":"","tid": %d,"ts": %.2f,"name":%a,"ph":"I"%a}|json}
      self.pid tid ts str_val name
      (emit_args_o_ pp_user_data_)
      args;
    ()

  let emit_name_thread ~tid ~name (self : t) : unit =
    emit_sep_ self;
    Printf.fprintf self.oc
      {json|{"pid": %d,"tid": %d,"name":"thread_name","ph":"M"%a}|json} self.pid
      tid
      (emit_args_o_ pp_user_data_)
      [ "name", `String name ];
    ()

  let emit_name_process ~name (self : t) : unit =
    emit_sep_ self;
    Printf.fprintf self.oc
      {json|{"pid": %d,"name":"process_name","ph":"M"%a}|json} self.pid
      (emit_args_o_ pp_user_data_)
      [ "name", `String name ];
    ()
end

let bg_thread ~out (events : event B_queue.t) : unit =
  let writer = Writer.create ~out () in
  protect ~finally:(fun () -> Writer.close writer) @@ fun () ->
  let spans : span_info Span_tbl.t = Span_tbl.create 32 in

  (* how to deal with an event *)
  let handle_ev (ev : event) : unit =
    match ev with
    | E_message
        { (* __FUNCTION__; __FILE__; __LINE__; *) tid; msg; time_us; data } ->
      Writer.emit_instant_event ~tid ~name:msg ~ts:time_us ~args:data writer
    | E_define_span
        { (* __FUNCTION__; __FILE__; __LINE__; *) tid; name; id; time_us; data }
      ->
      (* save the span so we find it at exit *)
      Span_tbl.add spans id
        {
          (* __FUNCTION__; __FILE__; __LINE__; *) tid;
          name;
          start_us = time_us;
          data;
        }
    | E_exit_span { id; time_us = stop_us } ->
      (match Span_tbl.find_opt spans id with
      | None -> (* bug! TODO: emit warning *) ()
      | Some
          { (* __FUNCTION__; __FILE__; __LINE__; *) tid; name; start_us; data }
        ->
        Span_tbl.remove spans id;
        Writer.emit_duration_event ~tid ~name ~start:start_us ~end_:stop_us
          ~args:data writer)
    | E_name_process { name } -> Writer.emit_name_process ~name writer
    | E_name_thread { tid; name } -> Writer.emit_name_thread ~tid ~name writer
  in

  try
    while true do
      let ev = B_queue.pop events in
      handle_ev ev
    done
  with B_queue.Closed ->
    (* warn if app didn't close all spans *)
    if Span_tbl.length spans > 0 then
      Printf.eprintf "trace-tef: warning: %d spans were not closed\n%!"
        (Span_tbl.length spans);
    ()

type output =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

let collector ~out () : collector =
  let module M = struct
    let active = A.make true

    (** generator for span ids *)
    let span_id_gen_ = A.make 0

    (* queue of messages to write *)
    let events : event B_queue.t = B_queue.create ()

    (* writer thread. It receives events and writes them to [oc]. *)
    let t_write : Thread.t = Thread.create (fun () -> bg_thread ~out events) ()

    let shutdown () =
      if A.exchange active false then (
        B_queue.close events;
        Thread.join t_write
      )

    let[@inline] get_tid_ () : int =
      if !Mock_.enabled then
        3
      else
        Thread.id (Thread.self ())

    let enter_span ?__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name : span =
      let span = Int64.of_int (A.fetch_and_add span_id_gen_ 1) in
      let tid = get_tid_ () in
      let time_us = now_us () in
      B_queue.push events
        (E_define_span
           {
             (* __FUNCTION__; __FILE__; __LINE__; *) tid;
             name;
             time_us;
             id = span;
             data;
           });
      span

    let exit_span span : unit =
      let time_us = now_us () in
      B_queue.push events (E_exit_span { id = span; time_us })

    let message ?__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data msg : unit =
      let time_us = now_us () in
      let tid = get_tid_ () in
      B_queue.push events
        (E_message
           { (* __FUNCTION__; __FILE__; __LINE__; *) tid; time_us; msg; data })

    let name_process name : unit = B_queue.push events (E_name_process { name })

    let name_thread name : unit =
      let tid = get_tid_ () in
      B_queue.push events (E_name_thread { tid; name })
  end in
  (module M)

let setup ?(out = `Env) () =
  match out with
  | `Stderr -> Trace.setup_collector @@ collector ~out:`Stderr ()
  | `Stdout -> Trace.setup_collector @@ collector ~out:`Stdout ()
  | `File path -> Trace.setup_collector @@ collector ~out:(`File path) ()
  | `Env ->
    (match Sys.getenv_opt "TRACE" with
    | Some "1" ->
      let path = "trace.json" in
      let c = collector ~out:(`File path) () in
      Trace.setup_collector c
    | Some path ->
      let c = collector ~out:(`File path) () in
      Trace.setup_collector c
    | None -> ())

let with_setup ?out f =
  setup ?out ();
  protect ~finally:Trace.shutdown f

module Internal_ = struct
  let mock_all_ () = Mock_.enabled := true
end
