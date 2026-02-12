(** Write JSON events to a buffer.

    This is the part of the code that knows how to emit TEF-compliant JSON from
    raw event data. *)

open Types

val emit_duration_event :
  pid:int ->
  tid:int ->
  name:string ->
  start:float ->
  end_:float ->
  args:(string * Trace_core.user_data) list ->
  Buffer.t ->
  unit

val emit_begin_async :
  pid:int ->
  tid:int ->
  name:string ->
  trace_id:trace_id ->
  ts:float ->
  args:(string * Trace_core.user_data) list ->
  Buffer.t ->
  unit

val emit_end_async :
  pid:int ->
  tid:int ->
  name:string ->
  trace_id:trace_id ->
  ts:float ->
  args:(string * Trace_core.user_data) list ->
  Buffer.t ->
  unit

val emit_instant_event :
  pid:int ->
  tid:int ->
  name:string ->
  ts:float ->
  args:(string * Trace_core.user_data) list ->
  Buffer.t ->
  unit

val emit_name_thread : pid:int -> tid:int -> name:string -> Buffer.t -> unit
val emit_name_process : pid:int -> name:string -> Buffer.t -> unit
val emit_process_sort_index : pid:int -> int -> Buffer.t -> unit
val emit_thread_sort_index : pid:int -> tid:int -> int -> Buffer.t -> unit

val emit_counter :
  pid:int -> tid:int -> name:string -> ts:float -> Buffer.t -> float -> unit
