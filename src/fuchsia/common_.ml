module A = Trace_core.Internal_.Atomic_

module Span_tbl = Hashtbl.Make (struct
  include Int64

  let hash : t -> int = Hashtbl.hash
end)

let on_tracing_error =
  ref (fun s -> Printf.eprintf "trace-fuchsia error: %s\n%!" s)
