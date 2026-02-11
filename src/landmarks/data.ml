(** Basic data types for Landmarks profiling export *)

type gc_info = {
  minor_words: float;
  promoted_words: float;
  major_words: float;
}
(** Basic GC statistics *)

(** Convert gc_info to yojson *)
let gc_info_to_yojson (self : gc_info) : Yojson.Safe.t =
  `Assoc
    [
      "minor_words", `Float self.minor_words;
      "promoted_words", `Float self.promoted_words;
      "major_words", `Float self.major_words;
    ]

type timing = {
  start_time: float;  (** Start timestamp (seconds) *)
  end_time: float;  (** End timestamp (seconds) *)
  duration: float;  (** Duration in seconds *)
  cpu_time: float;  (** CPU time in seconds *)
}
(** Timing information *)

(** Convert timing to yojson *)
let timing_to_yojson (self : timing) : Yojson.Safe.t =
  `Assoc
    [
      "start_time", `Float self.start_time;
      "end_time", `Float self.end_time;
      "duration", `Float self.duration;
      "cpu_time", `Float self.cpu_time;
    ]

type landmark = {
  name: string;
  location: string option;
  timing: timing;
  gc_before: gc_info;
  gc_after: gc_info;
  call_count: int;
}
(** A single landmark measurement *)

(** Convert landmark to yojson *)
let landmark_to_yojson (self : landmark) : Yojson.Safe.t =
  `Assoc
    ([
       "name", `String self.name;
       "timing", timing_to_yojson self.timing;
       "gc_before", gc_info_to_yojson self.gc_before;
       "gc_after", gc_info_to_yojson self.gc_after;
       "call_count", `Int self.call_count;
     ]
    @
    match self.location with
    | None -> []
    | Some loc -> [ "location", `String loc ])

type landmark_collection = {
  landmarks: landmark list;
  total_time: float;
  timestamp: float;
}
(** A collection of landmarks *)

(** Convert landmark_collection to yojson *)
let landmark_collection_to_yojson (coll : landmark_collection) : Yojson.Safe.t =
  `Assoc
    [
      "landmarks", `List (List.map landmark_to_yojson coll.landmarks);
      "total_time", `Float coll.total_time;
      "timestamp", `Float coll.timestamp;
    ]

(** Helper to get current GC info *)
let get_gc_info () : gc_info =
  let minor_words, promoted_words, major_words = Gc.counters () in
  { minor_words; promoted_words; major_words }
