open Trace_core
open Common_
module Sub = Trace_subscriber

type t = {
  oc: out_channel;
  jsonl: bool;  (** JSONL mode, one json event per line *)
  mutable first: bool;  (** first event? useful in json mode *)
  buf: Buffer.t;  (** Buffer to write into *)
  must_close: bool;  (** Do we have to close the underlying channel [oc]? *)
  pid: int;
}

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
    {json|{"pid":%d,"tid":%d,"ts":%.2f,"name":"c","ph":"C"%a}|json} self.pid tid
    ts
    (emit_args_o_ pp_user_data_)
    [ name, U_float f ];
  Buffer.output_buffer self.oc self.buf
