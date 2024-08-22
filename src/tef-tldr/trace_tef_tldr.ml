open Trace_core

let spf = Printf.sprintf
let fpf = Printf.fprintf

type output = [ `File of string ]

(** Env variable used to communicate to subprocesses, which trace ID to use *)
let env_var_trace_id = "TRACE_TEF_TLDR_TRACE_ID"

(** Env variable used to communicate to subprocesses, which trace ID to use *)
let env_var_unix_socket = "TRACE_TEF_TLDR_SOCKET"

let get_unix_socket () =
  match Sys.getenv_opt env_var_unix_socket with
  | Some s -> s
  | None ->
    let s = "/tmp/tldr.socket" in
    (* children must agree on the socket file *)
    Unix.putenv env_var_unix_socket s;
    s

type as_client = {
  trace_id: string;
  socket: string;
  emit_tef_at_exit: string option;
      (** For parent, ask daemon to emit traces here *)
}

type role = as_client option

let to_hex (s : string) : string =
  let open String in
  let i_to_hex (i : int) =
    if i < 10 then
      Char.chr (i + Char.code '0')
    else
      Char.chr (i - 10 + Char.code 'a')
  in

  let res = Bytes.create (2 * length s) in
  for i = 0 to length s - 1 do
    let n = Char.code (get s i) in
    Bytes.set res (2 * i) (i_to_hex ((n land 0xf0) lsr 4));
    Bytes.set res ((2 * i) + 1) (i_to_hex (n land 0x0f))
  done;
  Bytes.unsafe_to_string res

let create_trace_id () : string =
  let now = Unix.gettimeofday () in
  let rand = Random.State.make_self_init () in

  let rand_bytes = Bytes.create 16 in
  for i = 0 to Bytes.length rand_bytes - 1 do
    Bytes.set rand_bytes i (Random.State.int rand 256 |> Char.chr)
  done;
  (* convert to hex *)
  spf "tr-%d-%s" (int_of_float now) (to_hex @@ Bytes.unsafe_to_string rand_bytes)

(** Find what this particular process has to do wrt tracing *)
let find_role ~out () : role =
  match Sys.getenv_opt env_var_trace_id with
  | Some trace_id ->
    Some { trace_id; emit_tef_at_exit = None; socket = get_unix_socket () }
  | None ->
    let write_to_file path =
      (* normalize path so the daemon knows what we're talking about *)
      let path =
        if Filename.is_relative path then
          Filename.concat (Unix.getcwd ()) path
        else
          path
      in
      let trace_id = create_trace_id () in
      Unix.putenv env_var_trace_id trace_id;
      { trace_id; emit_tef_at_exit = Some path; socket = get_unix_socket () }
    in

    (match out with
    | `File path -> Some (write_to_file path)
    | `Env ->
      (match Sys.getenv_opt "TRACE" with
      | Some ("1" | "true") -> Some (write_to_file "trace.json")
      | Some path -> Some (write_to_file path)
      | None -> None))

let collector_ (client : as_client) : collector =
  (* connect to unix socket *)
  let sock = Unix.socket Unix.PF_UNIX Unix.SOCK_STREAM 0 in
  (try Unix.connect sock (Unix.ADDR_UNIX client.socket)
   with exn ->
     failwith
     @@ spf "Could not open socket to `tldr` demon at %S: %s" client.socket
          (Printexc.to_string exn));
  let out = Unix.out_channel_of_descr sock in

  (* what to do when the collector shuts down *)
  let finally () =
    (* ask the collector to emit the trace in a user-chosen file, perhaps *)
    Option.iter
      (fun file -> fpf out "EMIT_TEF %s\n" file)
      client.emit_tef_at_exit;
    (try flush out with _ -> ());
    try Unix.close sock with _ -> ()
  in

  fpf out "OPEN %s\n%!" client.trace_id;
  Trace_tef.Internal_.collector_jsonl ~finally ~out:(`Output out) ()

let collector ~out () : collector =
  let role = find_role ~out () in
  match role with
  | None -> assert false
  | Some c -> collector_ c

let setup ?(out = `Env) () =
  let role = find_role ~out () in
  match role with
  | None -> ()
  | Some c -> Trace_core.setup_collector @@ collector_ c

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Internal_ = struct
  include Trace_tef.Internal_
end
