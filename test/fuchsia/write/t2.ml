open Trace_fuchsia
open Trace_fuchsia.Writer

let pf = Printf.printf

module Str_ = struct
  open String

  let to_hex (s : string) : string =
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

  let of_hex_exn (s : string) : string =
    let n_of_c = function
      | '0' .. '9' as c -> Char.code c - Char.code '0'
      | 'a' .. 'f' as c -> 10 + Char.code c - Char.code 'a'
      | 'A' .. 'F' as c -> 10 + Char.code c - Char.code 'A'
      | _ -> invalid_arg "string: invalid hex"
    in
    if String.length s mod 2 <> 0 then
      invalid_arg "string: hex sequence must be of even length";
    let res = Bytes.make (String.length s / 2) '\x00' in
    for i = 0 to (String.length s / 2) - 1 do
      let n1 = n_of_c (String.get s (2 * i)) in
      let n2 = n_of_c (String.get s ((2 * i) + 1)) in
      let n = (n1 lsl 4) lor n2 in
      Bytes.set res i (Char.chr n)
    done;
    Bytes.unsafe_to_string res
end

let with_buf_chain (f : Buf_chain.t -> unit) : string =
  let buf_pool = Buf_pool.create () in
  let buffer = Buffer.create 32 in
  let buf_chain = Buf_chain.create ~sharded:true ~buf_pool () in
  f buf_chain;

  Buf_chain.ready_all_non_empty buf_chain;
  let exp = Exporter.of_buffer buffer in
  Buf_chain.pop_ready buf_chain ~f:exp.write_bufs;
  Buffer.contents buffer

let () = pf "first trace\n"

let () =
  let str =
    with_buf_chain (fun bufs ->
        Metadata.Magic_record.encode bufs;
        Thread_record.encode bufs ~as_ref:5 ~pid:1 ~tid:86 ();
        Event.Instant.encode bufs ~name:"hello" ~time_ns:1234_5678L
          ~t_ref:(Thread_ref.Ref 5)
          ~args:[ "x", A_int 42 ]
          ())
  in
  pf "%s\n" (Str_.to_hex str)

let () = pf "second trace\n"

let () =
  let str =
    with_buf_chain (fun bufs ->
        Metadata.Magic_record.encode bufs;
        Metadata.Initialization_record.(
          encode bufs ~ticks_per_secs:default_ticks_per_sec ());
        Thread_record.encode bufs ~as_ref:5 ~pid:1 ~tid:86 ();
        Metadata.Provider_info.encode bufs ~id:1 ~name:"ocaml-trace" ();
        Event.Duration_complete.encode bufs ~name:"outer"
          ~t_ref:(Thread_ref.Ref 5) ~time_ns:100_000L ~end_time_ns:5_000_000L
          ~args:[] ();
        Event.Duration_complete.encode bufs ~name:"inner"
          ~t_ref:(Thread_ref.Ref 5) ~time_ns:180_000L ~end_time_ns:4_500_000L
          ~args:[] ();
        Event.Instant.encode bufs ~name:"hello" ~time_ns:1_234_567L
          ~t_ref:(Thread_ref.Ref 5)
          ~args:[ "x", A_int 42 ]
          ())
  in
  (let oc = open_out "foo.fxt" in
   output_string oc str;
   close_out oc);
  pf "%s\n" (Str_.to_hex str)
