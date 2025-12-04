open Common_

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

let pp_user_data_ (out : Buffer.t) : Trace_core.user_data -> unit = function
  | `None -> raw_string out "null"
  | `Int i -> Printf.bprintf out "%d" i
  | `Bool b -> Printf.bprintf out "%b" b
  | `String s -> str_val out s
  | `Float f -> Printf.bprintf out "%g" f

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

let emit_duration_event ~pid ~tid ~name ~start ~end_ ~args buf : unit =
  let dur = end_ -. start in
  let ts = start in

  Printf.bprintf buf
    {json|{"pid":%d,"cat":"","tid": %d,"dur": %.2f,"ts": %.2f,"name":%a,"ph":"X"%a}|json}
    pid tid dur ts str_val name
    (emit_args_o_ pp_user_data_)
    args

let emit_manual_begin ~pid ~tid ~name ~(id : int64) ~ts ~args
    ~(flavor : Trace_core.span_flavor option) buf : unit =
  Printf.bprintf buf
    {json|{"pid":%d,"cat":"trace","id":%Ld,"tid": %d,"ts": %.2f,"name":%a,"ph":"%c"%a}|json}
    pid id tid ts str_val name
    (match flavor with
    | None | Some `Async -> 'b'
    | Some `Sync -> 'B')
    (emit_args_o_ pp_user_data_)
    args

let emit_manual_end ~pid ~tid ~name ~(id : int64) ~ts
    ~(flavor : Trace_core.span_flavor option) ~args buf : unit =
  Printf.bprintf buf
    {json|{"pid":%d,"cat":"trace","id":%Ld,"tid": %d,"ts": %.2f,"name":%a,"ph":"%c"%a}|json}
    pid id tid ts str_val name
    (match flavor with
    | None | Some `Async -> 'e'
    | Some `Sync -> 'E')
    (emit_args_o_ pp_user_data_)
    args

let emit_instant_event ~pid ~tid ~name ~ts ~args buf : unit =
  Printf.bprintf buf
    {json|{"pid":%d,"cat":"","tid": %d,"ts": %.2f,"name":%a,"ph":"I"%a}|json}
    pid tid ts str_val name
    (emit_args_o_ pp_user_data_)
    args

let emit_name_thread ~pid ~tid ~name buf : unit =
  Printf.bprintf buf
    {json|{"pid":%d,"tid": %d,"name":"thread_name","ph":"M"%a}|json} pid tid
    (emit_args_o_ pp_user_data_)
    [ "name", `String name ]

let emit_name_process ~pid ~name buf : unit =
  Printf.bprintf buf {json|{"pid":%d,"name":"process_name","ph":"M"%a}|json} pid
    (emit_args_o_ pp_user_data_)
    [ "name", `String name ]

let emit_counter ~pid ~tid ~name ~ts buf f : unit =
  Printf.bprintf buf
    {json|{"pid":%d,"tid":%d,"ts":%.2f,"name":"c","ph":"C"%a}|json} pid tid ts
    (emit_args_o_ pp_user_data_)
    [ name, `Float f ]
