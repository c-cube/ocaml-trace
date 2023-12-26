open Common_

type out =
  [ `Stdout
  | `Stderr
  | `File of string
  ]

type event =
  | E_write_buf of Buf.t
  | E_tick

type state = {
  buf_pool: Buf_pool.t;
  oc: out_channel;
  events: event B_queue.t;
}

let with_out_ (out : out) f =
  let oc, must_close =
    match out with
    | `Stdout -> stdout, false
    | `Stderr -> stderr, false
    | `File path -> open_out path, true
  in

  if must_close then (
    let finally () = close_out_noerr oc in
    Fun.protect ~finally (fun () -> f oc)
  ) else
    f oc

let handle_ev (self : state) (ev : event) : unit =
  match ev with
  | E_tick -> flush self.oc
  | E_write_buf buf ->
    output self.oc buf.buf 0 buf.offset;
    Buf_pool.recycle self.buf_pool buf

let bg_loop (self : state) : unit =
  let continue = ref true in

  while !continue do
    match B_queue.pop_all self.events with
    | exception B_queue.Closed -> continue := false
    | evs -> List.iter (handle_ev self) evs
  done

let bg_thread ~buf_pool ~out ~(events : event B_queue.t) () : unit =
  let@ oc = with_out_ out in
  let st = { oc; buf_pool; events } in
  bg_loop st

(* TODO:
   (* write a message about us closing *)
   Writer.emit_instant_event ~name:"tef-worker.exit"
     ~tid:(Thread.id @@ Thread.self ())
     ~ts:(now_us ()) ~args:[] writer;

   (* warn if app didn't close all spans *)
   if Span_tbl.length spans > 0 then
     Printf.eprintf "trace-tef: warning: %d spans were not closed\n%!"
       (Span_tbl.length spans);
*)

(** Thread that simply regularly "ticks", sending events to
     the background thread so it has a chance to write to the file,
     and call [f()] *)
let tick_thread events ~f : unit =
  try
    while true do
      Thread.delay 0.5;
      B_queue.push events E_tick;
      f ()
    done
  with B_queue.Closed -> ()
