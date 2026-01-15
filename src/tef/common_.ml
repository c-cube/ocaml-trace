module Sub = Trace_subscriber
module A = Trace_core.Internal_.Atomic_

let ( let@ ) = ( @@ )

type span_id = Sub.Span_sub.span_id
