open Trace_fuchsia
open Trace_fuchsia.Writer
module B = Benchmark

let pf = Printf.printf

let encode_1000_span (bufs : Buf_chain.t) () =
  for _i = 1 to 1000 do
    Event.Duration_complete.encode bufs ~name:"span" ~t_ref:(Thread_ref.Ref 5)
      ~time_ns:100_000L ~end_time_ns:5_000_000L ~args:[] ()
  done;
  Buf_chain.ready_all_non_empty bufs;
  Buf_chain.pop_ready bufs ~f:ignore;
  ()

let encode_300_span (bufs : Buf_chain.t) () =
  for _i = 1 to 100 do
    Event.Duration_complete.encode bufs ~name:"outer" ~t_ref:(Thread_ref.Ref 5)
      ~time_ns:100_000L ~end_time_ns:5_000_000L ~args:[] ();
    Event.Duration_complete.encode bufs ~name:"inner" ~t_ref:(Thread_ref.Ref 5)
      ~time_ns:180_000L ~end_time_ns:4_500_000L ~args:[] ();
    Event.Instant.encode bufs ~name:"hello" ~time_ns:1_234_567L
      ~t_ref:(Thread_ref.Ref 5)
      ~args:[ "x", A_int 42 ]
      ()
  done;
  Buf_chain.ready_all_non_empty bufs;
  Buf_chain.pop_ready bufs ~f:ignore;
  ()

let time_per_iter_ns n_per_iter (samples : B.t list) : float =
  let n_iters = ref 0L in
  let time = ref 0. in
  List.iter
    (fun (s : B.t) ->
      n_iters := Int64.add !n_iters s.iters;
      time := !time +. s.stime +. s.utime)
    samples;
  !time *. 1e9 /. (Int64.to_float !n_iters *. float n_per_iter)

let () =
  let buf_pool = Buf_pool.create () in
  let bufs = Buf_chain.create ~sharded:false ~buf_pool () in

  let samples =
    B.throughput1 4 ~name:"encode_1000_span" (encode_1000_span bufs) ()
  in
  B.print_gc samples;

  let [ (_, samples) ] = samples [@@warning "-8"] in
  let iter_per_ns = time_per_iter_ns 1000 samples in
  pf "%.3f ns/iter\n" iter_per_ns;

  ()

let () =
  let buf_pool = Buf_pool.create () in
  let bufs = Buf_chain.create ~sharded:false ~buf_pool () in
  let samples =
    B.throughput1 4 ~name:"encode_300_span" (encode_300_span bufs) ()
  in
  B.print_gc samples;

  let [ (_, samples) ] = samples [@@warning "-8"] in
  let iter_per_ns = time_per_iter_ns 300 samples in
  pf "%.3f ns/iter\n" iter_per_ns;
  ()
