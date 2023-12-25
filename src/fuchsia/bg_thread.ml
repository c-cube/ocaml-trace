open Common_

(** Background thread, takes events from the queue, puts them
       in context using local state, and writes fully resolved
       TEF events to [out]. *)
let bg_thread ~out (events : event B_queue.t) : unit =
  (* open a writer to [out] *)
  Writer.with_ ~out @@ fun writer ->
  (* local state, to keep track of span information and implicit stack context *)
  let spans : span_info Span_tbl.t = Span_tbl.create 32 in

  (* add function name, if provided, to the metadata *)
  let add_fun_name_ fun_name data : _ list =
    match fun_name with
    | None -> data
    | Some f -> ("function", `String f) :: data
  in

  (* how to deal with an event *)
  let handle_ev (ev : event) : unit =
    match ev with
    | E_tick -> Writer.flush writer
    | E_message { tid; msg; time_us; data } ->
      Writer.emit_instant_event ~tid ~name:msg ~ts:time_us ~args:data writer
    | E_define_span { tid; name; id; time_us; fun_name; data } ->
      let data = add_fun_name_ fun_name data in
      let info = { tid; name; start_us = time_us; data } in
      (* save the span so we find it at exit *)
      Span_tbl.add spans id info
    | E_exit_span { id; time_us = stop_us } ->
      (match Span_tbl.find_opt spans id with
      | None -> !on_tracing_error (Printf.sprintf "cannot find span %Ld" id)
      | Some { tid; name; start_us; data } ->
        Span_tbl.remove spans id;
        Writer.emit_duration_event ~tid ~name ~start:start_us ~end_:stop_us
          ~args:data writer)
    | E_add_data { id; data } ->
      (match Span_tbl.find_opt spans id with
      | None -> !on_tracing_error (Printf.sprintf "cannot find span %Ld" id)
      | Some info -> info.data <- List.rev_append data info.data)
    | E_enter_manual_span { tid; time_us; name; id; data; fun_name; flavor } ->
      let data = add_fun_name_ fun_name data in
      Writer.emit_manual_begin ~tid ~name ~id ~ts:time_us ~args:data ~flavor
        writer
    | E_exit_manual_span { tid; time_us; name; id; flavor; data } ->
      Writer.emit_manual_end ~tid ~name ~id ~ts:time_us ~flavor ~args:data
        writer
    | E_counter { tid; name; time_us; n } ->
      Writer.emit_counter ~name ~tid ~ts:time_us writer n
    | E_name_process { name } -> Writer.emit_name_process ~name writer
    | E_name_thread { tid; name } -> Writer.emit_name_thread ~tid ~name writer
  in

  try
    while true do
      (* get all the events in the incoming blocking queue, in
         one single critical section. *)
      let local = B_queue.pop_all events in
      List.iter handle_ev local
    done
  with B_queue.Closed ->
    (* write a message about us closing *)
    Writer.emit_instant_event ~name:"tef-worker.exit"
      ~tid:(Thread.id @@ Thread.self ())
      ~ts:(now_us ()) ~args:[] writer;

    (* warn if app didn't close all spans *)
    if Span_tbl.length spans > 0 then
      Printf.eprintf "trace-tef: warning: %d spans were not closed\n%!"
        (Span_tbl.length spans);
    ()

(** Thread that simply regularly "ticks", sending events to
       the background thread so it has a chance to write to the file *)
let tick_thread events : unit =
  try
    while true do
      Thread.delay 0.5;
      B_queue.push events E_tick
    done
  with B_queue.Closed -> ()
