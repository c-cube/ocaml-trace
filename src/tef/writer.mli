(** Write JSON events to a buffer.

    This is the part of the code that knows how to emit TEF-compliant JSON from
    raw event data. *)

open Common_
open Trace_core

val emit_duration_event :
  pid:int ->
  tid:int ->
  name:string ->
  start:float ->
  end_:float ->
  args:(string * Trace_core.user_data) list ->
  Buffer.t ->
  unit

val emit_manual_begin :
  pid:int ->
  tid:int ->
  name:string ->
  id:span ->
  ts:float ->
  args:(string * Trace_core.user_data) list ->
  flavor:Trace_core.span_flavor option ->
  Buffer.t ->
  unit

val emit_manual_end :
  pid:int ->
  tid:int ->
  name:string ->
  id:span ->
  ts:float ->
  flavor:Trace_core.span_flavor option ->
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

val emit_counter :
  pid:int -> tid:int -> name:string -> ts:float -> Buffer.t -> float -> unit
