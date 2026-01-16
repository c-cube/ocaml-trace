(** An exporter, takes JSON objects and writes them somewhere *)

type t = {
  on_json: Buffer.t -> unit;
      (** Takes a buffer and writes it somewhere. The buffer is only valid
          during this call and must not be stored. *)
  flush: unit -> unit;  (** Force write *)
  close: unit -> unit;  (** Close underlying resources *)
}
(** An exporter, takes JSON objects and writes them somewhere.

    This should be thread-safe if used in a threaded environment. *)

val of_out_channel : close_channel:bool -> jsonl:bool -> out_channel -> t
(** Export to the channel
    @param jsonl
      if true, export as a JSON object per line, otherwise export as a single
      big JSON array.
    @param close_channel if true, closing the exporter will close the channel *)

val of_buffer : jsonl:bool -> Buffer.t -> t
(** Emit into the buffer *)
