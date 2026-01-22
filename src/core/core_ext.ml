(** A few core extensions.

    @since NEXT_RELEASE *)

open Types

(** Additional extensions *)
type extension_event +=
  | Extension_set_thread_name of string
  | Extension_set_process_name of string

(** Specialized parameters *)
type extension_parameter +=
  | Extension_span_flavor of [ `Sync | `Async ]
        (** Tell the backend if this is a sync or async span *)

type metric +=
  | Metric_int of int  (** Int counter or gauge, supported by tracy, TEF, etc *)
  | Metric_float of float
        (** Float counter or gauge, supported by tracy, TEF, etc *)
