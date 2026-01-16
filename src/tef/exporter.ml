open Common_

type t = {
  on_json: Buffer.t -> unit;
  flush: unit -> unit;
  close: unit -> unit;
}

open struct
  let with_lock lock f =
    Mutex.lock lock;
    try
      let res = f () in
      Mutex.unlock lock;
      res
    with e ->
      let bt = Printexc.get_raw_backtrace () in
      Mutex.unlock lock;
      Printexc.raise_with_backtrace e bt
end

let of_out_channel ~close_channel ~jsonl oc : t =
  let lock = Mutex.create () in
  let first = ref true in
  let closed = ref false in
  let flush () =
    let@ () = with_lock lock in
    flush oc
  in
  let close () =
    let@ () = with_lock lock in
    if not !closed then (
      closed := true;
      if not jsonl then output_char oc ']';
      if close_channel then close_out_noerr oc
    )
  in
  let on_json buf =
    let@ () = with_lock lock in
    if not jsonl then
      if !first then (
        if not jsonl then output_char oc '[';
        first := false
      ) else
        output_string oc ",\n";
    Buffer.output_buffer oc buf;
    if jsonl then output_char oc '\n'
  in
  { flush; close; on_json }

let of_buffer ~jsonl (buf : Buffer.t) : t =
  let lock = Mutex.create () in
  let first = ref true in
  let closed = ref false in
  let close () =
    let@ () = with_lock lock in
    if not !closed then (
      closed := true;
      if not jsonl then Buffer.add_char buf ']'
    )
  in
  let on_json json =
    let@ () = with_lock lock in
    if not jsonl then
      if !first then (
        if not jsonl then Buffer.add_char buf '[';
        first := false
      ) else
        Buffer.add_string buf ",\n";
    Buffer.add_buffer buf json;
    if jsonl then Buffer.add_char buf '\n'
  in
  { flush = ignore; close; on_json }
