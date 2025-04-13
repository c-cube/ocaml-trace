(** Writer: knows how to write entries to a file in TEF format *)

open Trace_core
module Sub = Trace_subscriber

type t
(** A writer to a [out_channel]. It writes JSON entries in an array and closes
    the array at the end. *)

val create :
  mode:[ `Jsonl | `Single ] ->
  out:
    [< `File of trace_id
    | `File_append of trace_id
    | `Output of out_channel
    | `Stderr
    | `Stdout
    ] ->
  unit ->
  t

val flush : t -> unit
val close : t -> unit

val with_ :
  mode:[ `Jsonl | `Single ] ->
  out:
    [< `File of trace_id
    | `File_append of trace_id
    | `Output of out_channel
    | `Stderr
    | `Stdout
    ] ->
  (t -> 'a) ->
  'a
(** [with_ ~mode ~out f] creates a writer and calls [f] with it.
    @param mode
      choose between jsonl (easier to read and write) and single (single json
      object, directly usable in perfetto) *)

val emit_duration_event :
  tid:int ->
  name:trace_id ->
  start:float ->
  end_:float ->
  args:(trace_id * Sub.user_data) list ->
  t ->
  unit

val emit_manual_begin :
  tid:int ->
  name:trace_id ->
  id:trace_id ->
  ts:float ->
  args:(trace_id * Sub.user_data) list ->
  flavor:Sub.flavor option ->
  t ->
  unit

val emit_manual_end :
  tid:int ->
  name:trace_id ->
  id:trace_id ->
  ts:float ->
  flavor:Sub.flavor option ->
  args:(trace_id * Sub.user_data) list ->
  t ->
  unit

val emit_instant_event :
  tid:int ->
  name:trace_id ->
  ts:float ->
  args:(trace_id * Sub.user_data) list ->
  t ->
  unit

val emit_name_thread : tid:int -> name:trace_id -> t -> unit
val emit_name_process : name:trace_id -> t -> unit
val emit_counter : name:trace_id -> tid:int -> ts:float -> t -> float -> unit
