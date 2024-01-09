open Trace_fuchsia_write

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

let () =
  let l = List.init 100 (fun i -> Util.round_to_word i) in
  assert (List.for_all (fun x -> x mod 8 = 0) l)

let () =
  assert (Str_ref.inline 0 = 0b0000_0000_0000_0000);
  assert (Str_ref.inline 1 = 0b1000_0000_0000_0001);
  assert (Str_ref.inline 6 = 0b1000_0000_0000_0110);
  assert (Str_ref.inline 31999 = 0b1111_1100_1111_1111);
  ()

let () =
  let buf = Buf.create 128 in
  Buf.add_i64 buf 42L;
  assert (Buf.to_string buf = "\x2a\x00\x00\x00\x00\x00\x00\x00")

let () =
  let buf = Buf.create 128 in
  Buf.add_string buf "";
  assert (Buf.to_string buf = "")

let () =
  let buf = Buf.create 128 in
  Buf.add_string buf "hello";
  assert (Buf.to_string buf = "hello\x00\x00\x00")
