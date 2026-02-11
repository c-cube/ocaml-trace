(** Test program for the Runtime_events backend.

    This demonstrates and tests the Runtime_events backend by: 1. Emitting trace
    events 2. Subscribing to the ringbuffer 3. Collecting all events 4.
    Verifying expected events were emitted *)

let ( let@ ) = ( @@ )

(* Event types we'll collect *)
type collected_event =
  | Span_enter of string
  | Span_exit of string
  | Message of string
  | Metric_int of string * int
  | Metric_float of string * float

(* Simple recursive function to generate some trace activity *)
let rec fib x =
  let%trace () = "fib" in
  if x <= 2 then
    1
  else
    fib (x - 1) + fib (x - 2)

(* Function with explicit span *)
let do_work () =
  Trace_core.with_span ~__FILE__ ~__LINE__ "do_work" @@ fun _sp ->
  Trace_core.message "Starting work";
  Trace_core.counter_int "work_units" 100;

  let result = fib 10 in

  Trace_core.messagef (fun k -> k "Computed fib(10) = %d" result);
  Trace_core.counter_int "work_units" 200;
  result

(* Subscribe to runtime events and collect them *)
let collect_events () =
  let events = ref [] in

  (* Create a cursor to read from our own process *)
  let cursor = Runtime_events.create_cursor None in

  (* Set up callbacks *)
  let callbacks =
    Runtime_events.Callbacks.create ()
    (* Register callbacks for our custom events using type values *)
    |> Runtime_events.Callbacks.add_user_event
         Trace_runtime_events.String_type.ty (fun _domain_id _ts tag name ->
           match Runtime_events.User.tag tag with
           | Trace_runtime_events.Events.Tag_span_enter ->
             events := Span_enter name :: !events
           | Trace_runtime_events.Events.Tag_span_exit ->
             events := Span_exit name :: !events
           | Trace_runtime_events.Events.Tag_message ->
             events := Message name :: !events
           | _ -> ())
    |> Runtime_events.Callbacks.add_user_event
         Trace_runtime_events.String_int.ty
         (fun _domain_id _ts tag (name, value) ->
           match Runtime_events.User.tag tag with
           | Trace_runtime_events.Events.Tag_metric_int ->
             events := Metric_int (name, value) :: !events
           | _ -> ())
    |> Runtime_events.Callbacks.add_user_event
         Trace_runtime_events.String_float.ty
         (fun _domain_id _ts tag (name, value) ->
           match Runtime_events.User.tag tag with
           | Trace_runtime_events.Events.Tag_metric_float ->
             events := Metric_float (name, value) :: !events
           | _ -> ())
  in

  (* Read all events from the ringbuffer *)
  let _lost_events = Runtime_events.read_poll cursor callbacks None in

  List.rev !events

let () =
  (* Initialize the Runtime_events backend with start_events=false
     so we can manually control when to start *)
  Trace_runtime_events.setup ~start_events:false ();

  (* Start runtime events *)
  Runtime_events.start ();

  (* Set process and thread names *)
  Trace_core.set_process_name "test";
  Trace_core.set_thread_name "main";

  (* Do some traced work *)
  let result = do_work () in
  Printf.eprintf "result: %d\n" result;

  (* Collect events from the ringbuffer *)
  let events = collect_events () in

  Printf.eprintf "\ncollected %d events:\n" (List.length events);
  List.iter
    (fun ev ->
      match ev with
      | Span_enter name -> Printf.eprintf "  - span enter: %s\n" name
      | Span_exit name -> Printf.eprintf "  - span exit: %s\n" name
      | Message msg -> Printf.eprintf "  - message: %s\n" msg
      | Metric_int (name, value) ->
        Printf.eprintf "  - metric int: %s = %d\n" name value
      | Metric_float (name, value) ->
        Printf.eprintf "  - metric float: %s = %f\n" name value)
    events;

  (* Verify expected events *)
  let has_do_work_enter =
    List.exists
      (function
        | Span_enter "do_work" -> true
        | _ -> false)
      events
  in
  let has_do_work_exit =
    List.exists
      (function
        | Span_exit "do_work" -> true
        | _ -> false)
      events
  in
  let has_fib_spans =
    List.filter
      (function
        | Span_enter "fib" | Span_exit "fib" -> true
        | _ -> false)
      events
  in
  let has_starting_work =
    List.exists
      (function
        | Message "Starting work" -> true
        | _ -> false)
      events
  in
  let has_metrics =
    List.filter
      (function
        | Metric_int ("work_units", _) -> true
        | _ -> false)
      events
  in

  Printf.eprintf "\nVerification:\n";
  Printf.eprintf "  - do_work span enter: %b\n" has_do_work_enter;
  Printf.eprintf "  - do_work span exit: %b\n" has_do_work_exit;
  Printf.eprintf "  - fib spans (enter+exit): %d\n" (List.length has_fib_spans);
  Printf.eprintf "  - 'Starting work' message: %b\n" has_starting_work;
  Printf.eprintf "  - work_units metrics: %d\n" (List.length has_metrics);

  (* Check assertions *)
  assert has_do_work_enter;
  assert has_do_work_exit;
  assert (List.length has_fib_spans = 218);
  assert has_starting_work;
  assert (List.length has_metrics = 2);

  Printf.eprintf "\nall good :-)\n";

  Trace_core.shutdown ()
