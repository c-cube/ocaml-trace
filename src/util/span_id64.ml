open struct
  module A = Trace_core.Internal_.Atomic_
end

type t = int64

module Gen : sig
  type t

  val create : unit -> t
  val gen : t -> int64
end = struct
  type t = int A.t

  let create () = A.make 0
  let[@inline] gen self : int64 = A.fetch_and_add self 1 |> Int64.of_int
end

module Trace_id_generator = struct
  type t = int A.t

  let create () = A.make 0
  let[@inline] gen self = A.fetch_and_add self 1 |> Int64.of_int
end
