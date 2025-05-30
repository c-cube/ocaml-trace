(** Write fuchsia events into buffers.

    Reference: https://fuchsia.dev/fuchsia-src/reference/tracing/trace-format *)

open Common_
module Util = Util

open struct
  let[@inline] int64_of_trace_id_ (id : Trace_core.trace_id) : int64 =
    if id == Trace_core.Collector.dummy_trace_id then
      0L
    else
      Bytes.get_int64_le (Bytes.unsafe_of_string id) 0
end

open Util

type user_data = Sub.user_data =
  | U_bool of bool
  | U_float of float
  | U_int of int
  | U_none
  | U_string of string

type arg =
  | A_bool of bool
  | A_float of float
  | A_int of int
  | A_none
  | A_string of string
  | A_kid of int64

(* NOTE: only works because [user_data] is a prefix of [arg] and is immutable *)
let arg_of_user_data : user_data -> arg = Obj.magic

(* NOTE: only works because [user_data] is a prefix of [arg] and is immutable *)
let args_of_user_data : (string * user_data) list -> (string * arg) list =
  Obj.magic

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

open struct
  (** maximum length as specified in the
      {{:https://fuchsia.dev/fuchsia-src/reference/tracing/trace-format} spec}
  *)
  let max_str_len = 32000

  (** Length of string, in words *)
  let[@inline] str_len_word (s : string) =
    let len = String.length s in
    assert (len <= max_str_len);
    round_to_word len lsr 3

  let str_len_word_maybe_too_big s =
    let len = min max_str_len (String.length s) in
    round_to_word len lsr 3
end

module Str_ref = struct
  type t = int
  (** 16 bits *)

  let[@inline never] inline_fail_ () =
    invalid_arg
      (Printf.sprintf "fuchsia: max length of strings is %d" max_str_len)

  let inline (size : int) : t =
    if size > max_str_len then
      inline_fail_ ()
    else if size = 0 then
      0
    else
      (1 lsl 15) lor size
end

(** [truncate_string s] truncates [s] to the maximum length allowed for strings.
    If [s] is already short enough, no allocation is done. *)
let[@inline] truncate_string s : string =
  if String.length s <= max_str_len then
    s
  else
    String.sub s 0 max_str_len

module Thread_ref = struct
  type t =
    | Ref of int
    | Inline of {
        pid: int;
        tid: int;
      }

  let inline ~pid ~tid : t = Inline { pid; tid }

  let ref x : t =
    if x = 0 || x > 255 then
      invalid_arg "fuchsia: thread inline ref must be >0 < 256";
    Ref x

  let size_word (self : t) : int =
    match self with
    | Ref _ -> 0
    | Inline _ -> 2

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
    let size_word = 1

    let encode (bufs : Buf_chain.t) =
      let@ buf = Buf_chain.with_buf bufs ~available_word:size_word in
      Buf.add_i64 buf value
  end

  module Initialization_record = struct
    let size_word = 2

    (** Default: 1 tick = 1 ns *)
    let default_ticks_per_sec = 1_000_000_000L

    let encode (bufs : Buf_chain.t) ~ticks_per_secs () : unit =
      let@ buf = Buf_chain.with_buf bufs ~available_word:size_word in
      let hd = I64.(1L lor (of_int size_word lsl 4)) in
      Buf.add_i64 buf hd;
      Buf.add_i64 buf ticks_per_secs
  end

  module Provider_info = struct
    let size_word ~name () = 1 + str_len_word name

    let encode (bufs : Buf_chain.t) ~(id : int) ~name () : unit =
      let name = truncate_string name in
      let size = size_word ~name () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in
      let hd =
        I64.(
          (of_int size lsl 4)
          lor (1L lsl 16)
          lor (of_int id lsl 20)
          lor (of_int (Str_ref.inline (str_len_word name)) lsl 52))
      in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
  end

  module Provider_section = struct end
  module Trace_info = struct end
end

module Argument = struct
  type t = string * arg

  let check_valid_ : t -> unit = function
    | _, A_string s -> assert (String.length s < max_str_len)
    | _ -> ()

  let[@inline] is_i32_ (i : int) : bool = Int32.(to_int (of_int i) = i)

  let size_word (self : t) =
    let name, data = self in
    match data with
    | A_none | A_bool _ -> 1 + str_len_word name
    | A_int i when is_i32_ i -> 1 + str_len_word name
    | A_int _ -> (* int64 *) 2 + str_len_word name
    | A_float _ -> 2 + str_len_word name
    | A_string s -> 1 + str_len_word_maybe_too_big s + str_len_word name
    | A_kid _ -> 2 + str_len_word name

  open struct
    external int_of_bool : bool -> int = "%identity"
  end

  let encode (buf : Buf.t) (self : t) : unit =
    let name, data = self in
    let name = truncate_string name in
    let size = size_word self in

    (* part of header with argument name + size *)
    let hd_arg_size =
      I64.(
        (of_int size lsl 4)
        lor (of_int (Str_ref.inline (String.length name)) lsl 16))
    in

    match data with
    | A_none ->
      let hd = hd_arg_size in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
    | A_int i when is_i32_ i ->
      let hd = I64.(1L lor hd_arg_size lor (of_int i lsl 32)) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
    | A_int i ->
      (* int64 *)
      let hd = I64.(3L lor hd_arg_size) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_i64 buf (I64.of_int i)
    | A_float f ->
      let hd = I64.(5L lor hd_arg_size) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_i64 buf (I64.bits_of_float f)
    | A_string s ->
      let s = truncate_string s in
      let hd =
        I64.(
          6L lor hd_arg_size
          lor (of_int (Str_ref.inline (String.length s)) lsl 32))
      in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_string buf s
    | A_bool b ->
      let hd = I64.(9L lor hd_arg_size lor (of_int (int_of_bool b) lsl 16)) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name
    | A_kid kid ->
      (* int64 *)
      let hd = I64.(8L lor hd_arg_size) in
      Buf.add_i64 buf hd;
      Buf.add_string buf name;
      Buf.add_i64 buf kid
end

module Arguments = struct
  type t = Argument.t list

  let[@inline] len (self : t) : int =
    match self with
    | [] -> 0
    | [ _ ] -> 1
    | _ :: _ :: tl -> 2 + List.length tl

  let check_valid (self : t) =
    let len = len self in
    if len > 15 then
      invalid_arg (spf "fuchsia: can have at most 15 args, got %d" len);
    List.iter Argument.check_valid_ self;
    ()

  let[@inline] size_word (self : t) =
    match self with
    | [] -> 0
    | [ a ] -> Argument.size_word a
    | a :: b :: tl ->
      List.fold_left
        (fun n arg -> n + Argument.size_word arg)
        (Argument.size_word a + Argument.size_word b)
        tl

  let[@inline] encode (buf : Buf.t) (self : t) =
    let rec aux buf l =
      match l with
      | [] -> ()
      | x :: tl ->
        Argument.encode buf x;
        aux buf tl
    in

    match self with
    | [] -> ()
    | [ x ] -> Argument.encode buf x
    | x :: tl ->
      Argument.encode buf x;
      aux buf tl
end

(** record type = 3 *)
module Thread_record = struct
  let size_word : int = 3

  (** Record that [Thread_ref.ref as_ref] represents the pair [pid, tid] *)
  let encode (bufs : Buf_chain.t) ~as_ref ~pid ~tid () : unit =
    if as_ref <= 0 || as_ref > 255 then
      invalid_arg "fuchsia: thread_record: invalid ref";

    let@ buf = Buf_chain.with_buf bufs ~available_word:size_word in

    let hd = I64.(3L lor (of_int size_word lsl 4) lor (of_int as_ref lsl 16)) in
    Buf.add_i64 buf hd;
    Buf.add_i64 buf (I64.of_int pid);
    Buf.add_i64 buf (I64.of_int tid)
end

(** record type = 4 *)
module Event = struct
  (** type=0 *)
  module Instant = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns ~args
        () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      (* set category = 0 *)
      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (of_int (Arguments.len args) lsl 20)
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

  (** type=1 *)
  module Counter = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args + 1 (* counter id *)

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns ~args
        () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (1L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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
      (* just use 0 as counter id *)
      Buf.add_i64 buf 0L;
      ()
  end

  (** type=2 *)
  module Duration_begin = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns ~args
        () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (2L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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

  (** type=3 *)
  module Duration_end = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns ~args
        () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (3L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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

  (** type=4 *)
  module Duration_complete = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args + 1 (* end timestamp *)

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns
        ~end_time_ns ~args () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      (* set category = 0 *)
      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (4L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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
      Buf.add_i64 buf end_time_ns;
      ()
  end

  (** type=5 *)
  module Async_begin = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args + 1 (* async id *)

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns
        ~(async_id : Trace_core.trace_id) ~args () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (5L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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
      Buf.add_i64 buf (int64_of_trace_id_ async_id);
      ()
  end

  (** type=7 *)
  module Async_end = struct
    let size_word ~name ~t_ref ~args () : int =
      1 + Thread_ref.size_word t_ref + 1 (* timestamp *) + str_len_word name
      + Arguments.size_word args + 1 (* async id *)

    let encode (bufs : Buf_chain.t) ~name ~(t_ref : Thread_ref.t) ~time_ns
        ~(async_id : Trace_core.trace_id) ~args () : unit =
      let name = truncate_string name in
      let size = size_word ~name ~t_ref ~args () in
      let@ buf = Buf_chain.with_buf bufs ~available_word:size in

      let hd =
        I64.(
          4L
          lor (of_int size lsl 4)
          lor (7L lsl 16)
          lor (of_int (Arguments.len args) lsl 20)
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
      Buf.add_i64 buf (int64_of_trace_id_ async_id);
      ()
  end
end

(** record type = 7 *)
module Kernel_object = struct
  let size_word ~name ~args () : int =
    1 + 1 + str_len_word name + Arguments.size_word args

  (* see:
     https://cs.opensource.google/fuchsia/fuchsia/+/main:zircon/system/public/zircon/types.h;l=441?q=ZX_OBJ_TYPE&ss=fuchsia%2Ffuchsia
  *)

  type ty = int

  let ty_process : ty = 1
  let ty_thread : ty = 2

  let encode (bufs : Buf_chain.t) ~name ~(ty : ty) ~(kid : int) ~args () : unit
      =
    let name = truncate_string name in
    let size = size_word ~name ~args () in
    let@ buf = Buf_chain.with_buf bufs ~available_word:size in

    let hd =
      I64.(
        7L
        lor (of_int size lsl 4)
        lor (of_int ty lsl 16)
        lor (of_int (Arguments.len args) lsl 40)
        lor (of_int (Str_ref.inline (String.length name)) lsl 24))
    in
    Buf.add_i64 buf hd;
    Buf.add_i64 buf (I64.of_int kid);
    Buf.add_string buf name;
    Arguments.encode buf args;
    ()
end
