open Trace_core
open Common_
module TLS = Thread_local_storage

let pid = Unix.getpid ()

type state = {
  active: bool A.t;
  events: Bg_thread.event B_queue.t;
  span_id_gen: int A.t;  (** Used for async spans *)
  bg_thread: Thread.t;
  buf_pool: Buf_pool.t;
  next_thread_ref: int A.t;  (** in [0x01 .. 0xff], to allocate thread refs *)
}

type span_info = {
  start_time_ns: int64;
  name: string;
  mutable data: (string * user_data) list;
}

(* TODO:
   (** key used to carry a unique "id" for all spans in an async context *)
   let key_async_id : int Meta_map.Key.t = Meta_map.Key.create ()

   let key_async_data : (string * [ `Sync | `Async ] option) Meta_map.Key.t =
     Meta_map.Key.create ()

   let key_data : (string * user_data) list ref Meta_map.Key.t =
     Meta_map.Key.create ()
*)

open struct
  let state_id_ = A.make 0

  (* re-raise exception with its backtrace *)
  external reraise : exn -> 'a = "%reraise"
end

type per_thread_state = {
  tid: int;
  state_id: int;  (** ID of the current collector state *)
  local_span_id_gen: int A.t;  (** Used for thread-local spans *)
  mutable thread_ref: FWrite.Thread_ref.t;
  mutable out: Output.t option;
  spans: span_info Span_tbl.t;  (** In-flight spans *)
}

let key_thread_local_st : per_thread_state TLS.key =
  TLS.new_key (fun () ->
      let tid = Thread.id @@ Thread.self () in
      {
        tid;
        state_id = A.get state_id_;
        thread_ref = FWrite.Thread_ref.inline ~pid ~tid;
        local_span_id_gen = A.make 0;
        out = None;
        spans = Span_tbl.create 32;
      })

let out_of_st (st : state) : Output.t =
  FWrite.Output.create () ~buf_pool:st.buf_pool ~send_buf:(fun buf ->
      if A.get st.active then (
        try B_queue.push st.events (E_write_buf buf) with B_queue.Closed -> ()
      ))

module C (St : sig
  val st : state
end)
() =
struct
  open St

  let state_id = 1 + A.fetch_and_add state_id_ 1

  (** prepare the thread's state *)
  let[@inline never] update_local_state (self : per_thread_state) : unit =
    (* get an output *)
    let out = out_of_st st in
    self.out <- Some out;

    (* try to allocate a thread ref for current thread *)
    let th_ref = A.fetch_and_add st.next_thread_ref 1 in
    if th_ref <= 0xff then (
      self.thread_ref <- FWrite.Thread_ref.ref th_ref;
      FWrite.Thread_record.encode out ~as_ref:th_ref ~tid:self.tid ~pid ()
    );
    ()

  (** Obtain the output for the current thread *)
  let[@inline] get_thread_output () : Output.t * per_thread_state =
    let st = TLS.get key_thread_local_st in
    if st.state_id != state_id || st.out == None then update_local_state st;
    Option.get st.out, st

  let shutdown () =
    if A.exchange st.active false then (
      B_queue.close st.events;
      (* wait for writer thread to be done. The writer thread will exit
         after processing remaining events because the queue is now closed *)
      Thread.join st.bg_thread
    )

  let enter_span ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name : span =
    let tls = TLS.get key_thread_local_st in
    let span = Int64.of_int (A.fetch_and_add tls.local_span_id_gen 1) in
    let time_ns = Time.now_ns () in
    Span_tbl.add tls.spans span { name; data; start_time_ns = time_ns };
    span

  let exit_span span : unit =
    let out, tls = get_thread_output () in
    let end_time_ns = Time.now_ns () in
    match Span_tbl.find_opt tls.spans span with
    | None -> !on_tracing_error (spf "unknown span %Ld" span)
    | Some info ->
      Span_tbl.remove tls.spans span;
      FWrite.Event.Duration_complete.encode out ~name:info.name
        ~t_ref:tls.thread_ref ~time_ns:info.start_time_ns ~end_time_ns
        ~args:info.data ()

  let with_span ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name f =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in
    let span = Int64.of_int (A.fetch_and_add tls.local_span_id_gen 1) in
    let info = { start_time_ns = time_ns; data; name } in
    Span_tbl.add tls.spans span info;

    let[@inline] exit () : unit =
      let end_time_ns = Time.now_ns () in
      Span_tbl.remove tls.spans span;
      FWrite.Event.Duration_complete.encode out ~name ~time_ns ~end_time_ns
        ~t_ref:tls.thread_ref ~args:info.data ()
    in

    try
      let x = f span in
      exit ();
      x
    with exn ->
      exit ();
      reraise exn

  let add_data_to_span span data =
    let tls = TLS.get key_thread_local_st in
    match Span_tbl.find_opt tls.spans span with
    | None -> !on_tracing_error (spf "unknown span %Ld" span)
    | Some info -> info.data <- List.rev_append data info.data

  let enter_manual_span ~(parent : explicit_span option) ~flavor
      ~__FUNCTION__:fun_name ~__FILE__:_ ~__LINE__:_ ~data name : explicit_span
      =
    assert false
  (* TODO:
     (* get the id, or make a new one *)
     let id =
       match parent with
       | Some m -> Meta_map.find_exn key_async_id m.meta
       | None -> A.fetch_and_add span_id_gen_ 1
     in
     let time_us = now_us () in
     B_queue.push events
       (E_enter_manual_span
          { id; time_us; tid = get_tid_ (); data; name; fun_name; flavor });
     {
       span = 0L;
       meta =
         Meta_map.(
           empty |> add key_async_id id |> add key_async_data (name, flavor));
     }
  *)

  let exit_manual_span (es : explicit_span) : unit = assert false
  (* TODO:
     let id = Meta_map.find_exn key_async_id es.meta in
     let name, flavor = Meta_map.find_exn key_async_data es.meta in
     let data =
       try !(Meta_map.find_exn key_data es.meta) with Not_found -> []
     in
     let time_us = now_us () in
     let tid = get_tid_ () in
     B_queue.push events
       (E_exit_manual_span { tid; id; name; time_us; data; flavor })
  *)

  let add_data_to_manual_span (es : explicit_span) data = assert false
  (* TODO:
     if data <> [] then (
       let data_ref, add =
         try Meta_map.find_exn key_data es.meta, false
         with Not_found -> ref [], true
       in
       let new_data = List.rev_append data !data_ref in
       data_ref := new_data;
       if add then es.meta <- Meta_map.add key_data data_ref es.meta
     )
  *)

  let message ?span:_ ~data msg : unit =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in
    FWrite.Event.Instant.encode out ~name:msg ~time_ns ~t_ref:tls.thread_ref
      ~args:data ()

  let counter_float ~data name f =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in
    FWrite.Event.Counter.encode out ~name:"c" ~time_ns ~t_ref:tls.thread_ref
      ~args:((name, `Float f) :: data)
      ()

  let counter_int ~data name i =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in
    FWrite.Event.Counter.encode out ~name:"c" ~time_ns ~t_ref:tls.thread_ref
      ~args:((name, `Int i) :: data)
      ()

  let name_process name : unit = ()
  (* TODO: B_queue.push events (E_name_process { name }) *)

  let name_thread name : unit = ()
  (* TODO:
     let tid = get_tid_ () in
     B_queue.push events (E_name_thread { tid; name })
  *)
end

let create ~out () : collector =
  let buf_pool = Buf_pool.create () in
  let events = B_queue.create () in

  let bg_thread =
    Thread.create (Bg_thread.bg_thread ~buf_pool ~out ~events) ()
  in
  let _tick_thread = Thread.create Bg_thread.tick_thread events in

  let st =
    {
      active = A.make true;
      buf_pool;
      bg_thread;
      events;
      span_id_gen = A.make 0;
      next_thread_ref = A.make 1;
    }
  in

  (* write header *)
  let out = out_of_st st in
  FWrite.Metadata.Magic_record.encode out;
  FWrite.Metadata.Initialization_record.(
    encode out ~ticks_per_secs:default_ticks_per_sec ());
  FWrite.Metadata.Provider_info.encode out ~id:0 ~name:"ocaml-trace" ();
  Output.flush out;
  Output.dispose out;

  let module Coll =
    C
      (struct
        let st = st
      end)
      ()
  in
  (module Coll)
