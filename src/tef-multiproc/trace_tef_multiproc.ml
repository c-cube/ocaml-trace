open Trace_core

let ( let@ ) = ( @@ )
let spf = Printf.sprintf

type output = [ `File of string ]

(** Env variable used to communicate to subprocesses, which directory into
    which they must write trace files as *)
let env_var = "TRACE_TEF_MULTIPROC_DIR"

(** Read all the ".jsonl" files in [dir] and write a single json into [final_file] *)
let aggregate_into ~dir ~final_file () : unit =
  let files = Sys.readdir dir in
  let oc = open_out final_file in
  let@ () =
    Fun.protect ~finally:(fun () ->
        output_char oc ']';
        close_out_noerr oc)
  in
  output_char oc '[';

  let first = ref true in
  let afternewline = ref false in

  (* buffer used to read lines *)
  let buf = Bytes.create 4096 in

  let emit_chunk buf i len =
    if len = 0 then
      ()
    else if Bytes.get buf i = '{' && Bytes.get buf (i + len - 1) <> '}' then
      (* incomplete chunk *)
      ()
    else (
      if !afternewline && !first then
        first := false
      else if !afternewline then (
        output_string oc ",\n";
        afternewline := false
      );
      output oc buf i len
    )
  in

  (* dump content of jsonl file into [oc]. Insert "," before every object
     except the very first one *)
  let dump_file file =
    let ic = open_in (Filename.concat dir file) in
    let@ () = Fun.protect ~finally:(fun () -> close_in_noerr ic) in
    let continue = ref true in
    while !continue do
      let n = input ic buf 0 (Bytes.length buf) in
      if n = 0 then continue := false;

      let start = ref 0 in
      while !start < n do
        match Bytes.index_from_opt buf !start '\n' with
        | None ->
          emit_chunk buf !start (n - !start);
          start := n
        | Some i ->
          (* found a new line, emit chunk before it if non empty *)
          if i > !start then emit_chunk buf !start (i - !start);
          afternewline := true;
          start := i + 1
      done
    done
  in
  Array.iter dump_file files

(** Remove the temporary directory and the files it contains. Assumes
    it doesn't contain sub-directories *)
let cleanup_dir_and_content (dir : string) : unit =
  try
    let entries = Sys.readdir dir in
    Array.iter (fun f -> Sys.remove (Filename.concat dir f)) entries;
    Sys.rmdir dir
  with e ->
    Printf.eprintf
      "ocaml_trace: error while cleaning temporary directory: %s\n%!"
      (Printexc.to_string e)

type child = { write_jsonl: string }

type parent = {
  dir: string;
  write_jsonl: string;
  final_file: string;
}

type role =
  [ `Nop
  | `Child of child
  | `Parent of parent
  ]

(** Find what this particular process has to do wrt tracing *)
let find_role ~out () : role =
  let file_of_dir dir =
    let pid = Unix.getpid () in
    Filename.concat dir (spf "%d.jsonl" pid)
  in
  let mk_tempdir () =
    let dir = Filename.temp_dir "ocaml_trace_tef_multiproc" ".tmp" in
    (* communicate the directory to child processes *)
    Unix.putenv env_var dir;
    dir
  in

  let write_to_file_as_parent path =
    let dir = mk_tempdir () in
    `Parent { final_file = path; dir; write_jsonl = file_of_dir dir }
  in

  match Sys.getenv_opt env_var with
  | Some dir -> `Child { write_jsonl = file_of_dir dir }
  | None ->
    (match out with
    | `File path -> write_to_file_as_parent path
    | `Env ->
      (match Sys.getenv_opt "TRACE" with
      | Some ("1" | "true") -> write_to_file_as_parent "trace.json"
      | Some path -> write_to_file_as_parent path
      | None -> `Nop))

let collector ~out () : collector =
  let role = find_role ~out () in
  match role with
  | `Nop -> assert false
  | `Child { write_jsonl } ->
    Trace_tef.Internal_.collector_jsonl ~finally:ignore
      ~out:(`File_append write_jsonl) ()
  | `Parent { dir; write_jsonl; final_file } ->
    (* what to do when the collector shuts down *)
    let finally () =
      aggregate_into ~dir ~final_file ();
      cleanup_dir_and_content dir
    in
    Trace_tef.Internal_.collector_jsonl ~finally ~out:(`File_append write_jsonl)
      ()

let setup ?(out = `Env) () =
  let role = find_role ~out () in
  match role with
  | `Nop -> ()
  | `Child { write_jsonl } ->
    Trace_core.setup_collector
    @@ Trace_tef.Internal_.collector_jsonl ~finally:ignore
         ~out:(`File_append write_jsonl) ()
  | `Parent { dir; write_jsonl; final_file } ->
    (* what to do when the collector shuts down *)
    let finally () =
      aggregate_into ~dir ~final_file ();
      cleanup_dir_and_content dir
    in

    Trace_core.setup_collector
    @@ Trace_tef.Internal_.collector_jsonl ~finally
         ~out:(`File_append write_jsonl) ()

let with_setup ?out () f =
  setup ?out ();
  Fun.protect ~finally:Trace_core.shutdown f

module Internal_ = struct
  include Trace_tef.Internal_
end
