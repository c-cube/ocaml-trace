(** A few core extensions.

    @since 0.11 *)

open Types

(** Additional extensions *)
type extension_event +=
  | Extension_set_thread_name of string
  | Extension_set_process_name of string
  | Extension_set_thread_sort_index of int
        (** https://github.com/google/perfetto/pull/3273/changes#diff-ecec88c33adb7591ee6aa88e29b62ad52ef443611cba5e0f0ecac9b5725afdba
        *)
  | Extension_set_process_sort_index of int

(** Specialized parameters *)
type extension_parameter +=
  | Extension_span_flavor of [ `Sync | `Async ]
        (** Tell the backend if this is a sync or async span *)

type metric +=
  | Metric_int of int  (** Int counter or gauge, supported by tracy, TEF, etc *)
  | Metric_float of float
        (** Float counter or gauge, supported by tracy, TEF, etc *)
