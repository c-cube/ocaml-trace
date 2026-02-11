(** Basic data types for Landmarks profiling export *)

(** GC statistics at a point in time *)
type gc_info = {
  minor_words : float;
  promoted_words : float;
  major_words : float;
  minor_collections : int;
  major_collections : int;
  heap_words : int;
  compactions : int;
}

val gc_info_to_yojson : gc_info -> Yojson.Safe.t
(** Convert gc_info to yojson *)

(** Timing information *)
type timing = {
  start_time : float;  (** Start timestamp (seconds) *)
  end_time : float;    (** End timestamp (seconds) *)
  duration : float;    (** Duration in seconds *)
  cpu_time : float;    (** CPU time in seconds *)
}

val timing_to_yojson : timing -> Yojson.Safe.t
(** Convert timing to yojson *)

(** A single landmark measurement *)
type landmark = {
  name : string;
  location : string option;
  timing : timing;
  gc_before : gc_info;
  gc_after : gc_info;
  call_count : int;
}

val landmark_to_yojson : landmark -> Yojson.Safe.t
(** Convert landmark to yojson *)

(** A collection of landmarks *)
type landmark_collection = {
  landmarks : landmark list;
  total_time : float;
  timestamp : float;
}

val landmark_collection_to_yojson : landmark_collection -> Yojson.Safe.t
(** Convert landmark_collection to yojson *)

val get_gc_info : unit -> gc_info
(** Helper to get current GC info from Gc.stat *)
