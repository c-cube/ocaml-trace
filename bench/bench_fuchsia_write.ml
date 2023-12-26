open Trace_fuchsia_write
module B = Benchmark

let pf = Printf.printf

let encode_1_span (out : Output.t) () =
  Event.Duration_complete.encode out ~name:"span" ~t_ref:(Thread_ref.Ref 5)
    ~time_ns:100_000L ~end_time_ns:5_000_000L ~args:[] ()

let encode_3_span (out : Output.t) () =
  Event.Duration_complete.encode out ~name:"outer" ~t_ref:(Thread_ref.Ref 5)
    ~time_ns:100_000L ~end_time_ns:5_000_000L ~args:[] ();
  Event.Duration_complete.encode out ~name:"inner" ~t_ref:(Thread_ref.Ref 5)
    ~time_ns:180_000L ~end_time_ns:4_500_000L ~args:[] ();
  Event.Instant.encode out ~name:"hello" ~time_ns:1_234_567L
    ~t_ref:(Thread_ref.Ref 5)
    ~args:[ "x", `Int 42 ]
    ()

let time_per_iter_ns (samples : B.t list) : float =
  let n_iters = ref 0L in
  let time = ref 0. in
  List.iter
    (fun (s : B.t) ->
      n_iters := Int64.add !n_iters s.iters;
      time := !time +. s.stime +. s.utime)
    samples;
  !time *. 1e9 /. Int64.to_float !n_iters

let () =
  let buf_pool = Buf_pool.create () in
  let out =
    Output.create ~buf_pool
      ~send_buf:(fun buf -> Buf_pool.recycle buf_pool buf)
      ()
  in

  let samples = B.throughput1 4 ~name:"encode_1_span" (encode_1_span out) () in
  B.print_gc samples;

  let [ (_, samples) ] = samples [@@warning "-8"] in

  let iter_per_ns = time_per_iter_ns samples in
  pf "%.3f ns/iter\n" iter_per_ns;

  ()

let () =
  let buf_pool = Buf_pool.create () in
  let out =
    Output.create ~buf_pool
      ~send_buf:(fun buf -> Buf_pool.recycle buf_pool buf)
      ()
  in

  let samples = B.throughput1 4 ~name:"encode_3_span" (encode_3_span out) () in
  B.print_gc samples;
  ()
