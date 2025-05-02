open Trace_core

val create : out:Bg_thread.out -> unit -> collector

(**/**)

module Internal_ : sig
  val mock_all_ : unit -> unit
end

(**/**)
