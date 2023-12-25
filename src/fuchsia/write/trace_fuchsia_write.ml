(** Write fuchsia events into buffers.

Reference: https://fuchsia.dev/fuchsia-src/reference/tracing/trace-format *)

module B = Bytes

open struct
  let spf = Printf.sprintf
end

module Util = struct
  (** How many bytes are missing for [n] to be a multiple of 8 *)
  let[@inline] missing_to_round (n : int) : int = lnot (n - 1) land 0b111

  (** Round up to a multiple of 8 *)
  let[@inline] round_to_word (n : int) : int = n + (lnot (n - 1) land 0b111)
end

open Util

module Buf = struct
  type t = {
    buf: bytes;
    mutable offset: int;
  }

  let create (n : int) : t =
    let buf = Bytes.create (round_to_word n) in
    { buf; offset = 0 }

  let[@inline] clear self = self.offset <- 0

  let[@inline] add_i64 (self : t) (i : int64) : unit =
    (* NOTE: we use LE, most systems are this way, even though fuchsia
       says we should use the system's native endianess *)
    Bytes.set_int64_le self.buf self.offset i;
    self.offset <- self.offset + 8

  let add_string (self : t) (s : string) : unit =
    let len = String.length s in
    Bytes.blit_string s 0 self.buf self.offset len;
    self.offset <- self.offset + len;

    (* add 0-padding *)
    let missing = missing_to_round len in
    Bytes.fill self.buf self.offset missing '\x00';
    self.offset <- self.offset + missing

  let to_string (self : t) : string = Bytes.sub_string self.buf 0 self.offset
end

type user_data = Trace_core.user_data

module I64 = struct
  include Int64

  let ( + ) = add
  let ( - ) = sub
  let ( = ) = equal
  let ( land ) = logand
  let ( lor ) = logor
  let lnot = lognot
  let ( lsl ) = shift_left
  let ( lsr ) = shift_right_logical
  let ( asr ) = shift_right
end

module Str_ref = struct
  type t = int
  (** 16 bits *)

  let inline (size : int) : t =
    if size > 32_000 then invalid_arg "fuchsia: max length of strings is 20_000";
    if size = 0 then
      0
    else
      (1 lsl 15) lor size
end

module Thread_ref = struct
  type t =
    | Ref of int
    | Inline of {
        pid: int;
        tid: int;
      }

  let ref x : t =
    if x = 0 || x > 255 then
      invalid_arg "fuchsia: thread inline ref must be >0 < 256";
    Ref x

  let size_B (self : t) : int =
    match self with
    | Ref _ -> 0
    | Inline _ -> 16

  (** 8-bit int for the reference *)
  let as_i8 (self : t) : int =
    match self with
    | Ref i -> i
    | Inline _ -> 0
end

(** record type = 0 *)
module Metadata = struct
  (** First record in the trace *)
  module Magic_record = struct
    let value = 0x0016547846040010L
    let size_B = 8
    let encode (buf : Buf.t) = Buf.add_i64 buf value
  end

  module Trace_info = struct end
end

module Argument = struct
  type t = string * user_data

  let check_valid _ = ()
  (* TODO: check string length *)

  let[@inline] is_i32_ (i : int) : bool = Int32.(to_int (of_int i) = i)

  (** Size in bytes *)
  let size_B (self : t) =
    let name, data = self in
    match data with
    | `None | `Bool _ -> 8 + round_to_word (String.length name)
    | `Int i when is_i32_ i -> 8 + round_to_word (String.length name)
    | `Int _ -> (* int64 *) 16 + round_to_word (String.length name)
    | `Float _ -> 16 + round_to_word (String.length name)
    | `String s ->
      8 + round_to_word (String.length s) + round_to_word (String.length name)

  open struct
    external int_of_bool : bool -> int = "%identity"
  end

  let encode (buf : Buf.t) (self : t) : unit =
    let name, data = self in
    let size = size_B self in

    (* part of header with argument name + size *)
    let hd_arg_size =
      I64.(
        (of_int size lsl 4)
        lor (of_int (Str_ref.inline (String.length name)) lsl 16))
    in

    match data with
    | `None ->
      let hd = hd_arg_size in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
    | `Int i when is_i32_ i ->
      let hd = I64.(1L lor hd_arg_size lor (of_int i lsl 32)) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
    | `Int i ->
      (* int64 *)
      let hd = I64.(3L lor hd_arg_size) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_i64 buf (I64.of_int i)
    | `Float f ->
      let hd = I64.(5L lor hd_arg_size) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_i64 buf (I64.bits_of_float f)
    | `String s ->
      let hd =
        I64.(
          6L lor hd_arg_size
          lor (of_int (Str_ref.inline (String.length s)) lsl 32))
      in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_string buf s
    | `Bool b ->
      let hd = I64.(9L lor hd_arg_size lor (of_int (int_of_bool b) lsl 16)) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
end

module Arguments = struct
  type t = Argument.t list

  let check_valid (self : t) =
    let len = List.length self in
    if len > 15 then
      invalid_arg (spf "fuchsia: can have at most 15 args, got %d" len);
    List.iter Argument.check_valid self;
    ()

  let[@inline] size_B (self : t) =
    List.fold_left (fun n arg -> n + Argument.size_B arg) 0 self

  let encode (buf : Buf.t) (self : t) =
    let rec aux buf l =
      match l with
      | [] -> ()
      | x :: tl ->
        Argument.encode buf x;
        aux buf tl
    in
    aux buf self
end

(** record type = 3 *)
module Thread_record = struct
  let size_B : int = 24

  (** Record that [Thread_ref.ref as_ref] represents the pair [pid, tid] *)
  let encode (buf : Buf.t) ~as_ref ~pid ~tid () : unit =
    let hd = I64.(3L lor (of_int size_B lsl 4) lor (of_int as_ref lsl 16)) in
    Buf.add_i64 buf hd;
    Buf.add_i64 buf (I64.of_int pid);
    Buf.add_i64 buf (I64.of_int tid)
end

(** record type = 4 *)
module Event = struct
  module Instant = struct
    (* TODO: find out how to encode tid/pid (are they both in64?)

       then compute size; then add encoder
    *)

    let size_B ~name ~t_ref ~args () : int =
      8 + Thread_ref.size_B t_ref + 8
      (* timestamp *) + round_to_word (String.length name)
      + Arguments.size_B args

    let encode (buf : Buf.t) ~name ~(t_ref : Thread_ref.t) ~time_ns ~args () :
        unit =
      let size = size_B ~name ~t_ref ~args () in
      (* set category = 0 *)
      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (of_int (List.length args) lsl 20)
          lor (of_int (Thread_ref.as_i8 t_ref) lsl 24)
          lor (of_int (Str_ref.inline (String.length name)) lsl 48))
      in
      Buf.add_i64 buf hd;
      Buf.add_i64 buf time_ns;

      (match t_ref with
      | Thread_ref.Inline { pid; tid } ->
        Buf.add_i64 buf (I64.of_int pid);
        Buf.add_i64 buf (I64.of_int tid)
      | Thread_ref.Ref _ -> ());

      Buf.add_string buf name;
      Arguments.encode buf args;
      ()
  end
end
