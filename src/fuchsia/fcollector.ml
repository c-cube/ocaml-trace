open Trace_core
open Common_
module TLS = Thread_local_storage
module Int_map = Map.Make (Int)

let pid = Unix.getpid ()

(** Thread-local stack of span info *)
module Span_info_stack : sig
  type t

  val create : unit -> t

  val push :
    t ->
    span ->
    name:string ->
    start_time_ns:int64 ->
    data:(string * user_data) list ->
    unit

  val pop : t -> int64 * string * int64 * (string * user_data) list
  val find_ : t -> span -> int option
  val add_data : t -> int -> (string * user_data) list -> unit
end = struct
  module BA = Bigarray
  module BA1 = Bigarray.Array1

  type int64arr = (int64, BA.int64_elt, BA.c_layout) BA1.t

  type t = {
    mutable len: int;
    mutable span: int64arr;
    mutable start_time_ns: int64arr;
    mutable name: string array;
    mutable data: (string * user_data) list array;
  }

  let init_size_ = 1

  let create () : t =
    {
      len = 0;
      span = BA1.create BA.Int64 BA.C_layout init_size_;
      start_time_ns = BA1.create BA.Int64 BA.C_layout init_size_;
      name = Array.make init_size_ "";
      data = Array.make init_size_ [];
    }

  let[@inline] cap self = Array.length self.name

  let grow_ (self : t) : unit =
    let new_cap = 2 * cap self in
    let new_span = BA1.create BA.Int64 BA.C_layout new_cap in
    BA1.blit self.span (BA1.sub new_span 0 self.len);
    let new_startime_ns = BA1.create BA.Int64 BA.C_layout new_cap in
    BA1.blit self.start_time_ns (BA1.sub new_startime_ns 0 self.len);
    let new_name = Array.make new_cap "" in
    Array.blit self.name 0 new_name 0 self.len;
    let new_data = Array.make new_cap [] in
    Array.blit self.data 0 new_data 0 self.len;
    self.span <- new_span;
    self.start_time_ns <- new_startime_ns;
    self.name <- new_name;
    self.data <- new_data

  let push (self : t) (span : int64) ~name ~start_time_ns ~data =
    if cap self = self.len then grow_ self;
    BA1.set self.span self.len span;
    BA1.set self.start_time_ns self.len start_time_ns;
    Array.set self.name self.len name;
    Array.set self.data self.len data;
    self.len <- self.len + 1

  let pop (self : t) =
    assert (self.len > 0);
    self.len <- self.len - 1;

    let span = BA1.get self.span self.len in
    let name = self.name.(self.len) in
    let start_time_ns = BA1.get self.start_time_ns self.len in
    let data = self.data.(self.len) in

    (* avoid holding onto old values *)
    Array.set self.name self.len "";
    Array.set self.data self.len [];

    span, name, start_time_ns, data

  let[@inline] add_data self i d : unit =
    assert (i < self.len);
    self.data.(i) <- List.rev_append d self.data.(i)

  exception Found of int

  let[@inline] find_ (self : t) span : _ option =
    try
      for i = self.len - 1 downto 0 do
        if Int64.equal (BA1.get self.span i) span then raise_notrace (Found i)
      done;

      None
    with Found i -> Some i
end

type async_span_info = {
  flavor: [ `Sync | `Async ] option;
  name: string;
  mutable data: (string * user_data) list;
}

let key_async_data : async_span_info Meta_map.key = Meta_map.Key.create ()

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
  spans: Span_info_stack.t;  (** In-flight spans *)
}

type state = {
  active: bool A.t;
  events: Bg_thread.event B_queue.t;
  span_id_gen: int A.t;  (** Used for async spans *)
  bg_thread: Thread.t;
  buf_pool: Buf_pool.t;
  next_thread_ref: int A.t;  (** in [0x01 .. 0xff], to allocate thread refs *)
  per_thread: per_thread_state Int_map.t A.t array;
      (** the state keeps tabs on thread-local state, so it can flush writers at
          the end. This is a tid-sharded array of maps. *)
}

let[@inline] mk_trace_id (self : state) : trace_id =
  let n = A.fetch_and_add self.span_id_gen 1 in
  let b = Bytes.create 8 in
  Bytes.set_int64_le b 0 (Int64.of_int n);
  Bytes.unsafe_to_string b

let key_thread_local_st : per_thread_state TLS.t = TLS.create ()

let[@inline never] mk_thread_local_st () =
  let tid = Thread.id @@ Thread.self () in
  let st =
    {
      tid;
      state_id = A.get state_id_;
      thread_ref = FWrite.Thread_ref.inline ~pid ~tid;
      local_span_id_gen = A.make 0;
      out = None;
      spans = Span_info_stack.create ();
    }
  in
  TLS.set key_thread_local_st st;
  st

let[@inline] get_thread_local_st () =
  match TLS.get_opt key_thread_local_st with
  | Some k -> k
  | None -> mk_thread_local_st ()

let out_of_st (st : state) : Output.t =
  FWrite.Output.create () ~buf_pool:st.buf_pool ~send_buf:(fun buf ->
      try B_queue.push st.events (E_write_buf buf) with B_queue.Closed -> ())

module C
    (St : sig
      val st : state
    end)
    () =
struct
  open St

  let state_id = 1 + A.fetch_and_add state_id_ 1

  (** prepare the thread's state *)
  let[@inline never] update_or_init_local_state (self : per_thread_state) : unit
      =
    (* get an output *)
    let out = out_of_st st in
    self.out <- Some out;

    (* try to allocate a thread ref for current thread *)
    let th_ref = A.fetch_and_add st.next_thread_ref 1 in
    if th_ref <= 0xff then (
      self.thread_ref <- FWrite.Thread_ref.ref th_ref;
      FWrite.Thread_record.encode out ~as_ref:th_ref ~tid:self.tid ~pid ()
    );

    (* add to [st]'s list of threads *)
    let shard_of_per_thread = st.per_thread.(self.tid land 0b1111) in
    while
      let old = A.get shard_of_per_thread in
      not
        (A.compare_and_set shard_of_per_thread old
           (Int_map.add self.tid self old))
    do
      ()
    done;

    let on_exit _ =
      while
        let old = A.get shard_of_per_thread in
        not
          (A.compare_and_set shard_of_per_thread old
             (Int_map.remove self.tid old))
      do
        ()
      done;
      Option.iter Output.flush self.out
    in

    (* after thread exits, flush output and remove from global list *)
    Gc.finalise on_exit (Thread.self ());
    ()

  (** Obtain the output for the current thread *)
  let[@inline] get_thread_output () : Output.t * per_thread_state =
    let tls = get_thread_local_st () in
    if tls.state_id != state_id || tls.out == None then
      update_or_init_local_state tls;
    let out =
      match tls.out with
      | None -> assert false
      | Some o -> o
    in
    out, tls

  let close_per_thread (tls : per_thread_state) =
    Option.iter Output.flush tls.out

  (** flush all outputs *)
  let flush_all_outputs_ () =
    Array.iter
      (fun shard ->
        let tls_l = A.get shard in
        Int_map.iter (fun _tid tls -> close_per_thread tls) tls_l)
      st.per_thread

  let shutdown () =
    if A.exchange st.active false then (
      flush_all_outputs_ ();

      B_queue.close st.events;
      (* wait for writer thread to be done. The writer thread will exit
         after processing remaining events because the queue is now closed *)
      Thread.join st.bg_thread
    )

  let enter_span ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name : span =
    let tls = get_thread_local_st () in
    let span = Int64.of_int (A.fetch_and_add tls.local_span_id_gen 1) in
    let time_ns = Time.now_ns () in
    Span_info_stack.push tls.spans span ~name ~data ~start_time_ns:time_ns;
    span

  let exit_span span : unit =
    let out, tls = get_thread_output () in
    let end_time_ns = Time.now_ns () in

    let span', name, start_time_ns, data = Span_info_stack.pop tls.spans in
    if span <> span' then
      !on_tracing_error
        (spf "span mismatch: top is %Ld, expected %Ld" span' span)
    else
      FWrite.Event.Duration_complete.encode out ~name ~t_ref:tls.thread_ref
        ~time_ns:start_time_ns ~end_time_ns ~args:data ()

  let with_span ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name f =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in
    let span = Int64.of_int (A.fetch_and_add tls.local_span_id_gen 1) in
    Span_info_stack.push tls.spans span ~start_time_ns:time_ns ~data ~name;

    let[@inline] exit () : unit =
      let end_time_ns = Time.now_ns () in

      let _span', _, _, data = Span_info_stack.pop tls.spans in
      assert (span = _span');
      FWrite.Event.Duration_complete.encode out ~name ~time_ns ~end_time_ns
        ~t_ref:tls.thread_ref ~args:data ()
    in

    try
      let x = f span in
      exit ();
      x
    with exn ->
      exit ();
      reraise exn

  let add_data_to_span span data =
    let tls = get_thread_local_st () in
    match Span_info_stack.find_ tls.spans span with
    | None -> !on_tracing_error (spf "unknown span %Ld" span)
    | Some idx -> Span_info_stack.add_data tls.spans idx data

  let enter_manual_span ~(parent : explicit_span_ctx option) ~flavor
      ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~data name : explicit_span =
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in

    (* get the id, or make a new one *)
    let trace_id =
      match parent with
      | Some m -> m.trace_id
      | None -> mk_trace_id st
    in

    FWrite.Event.Async_begin.encode out ~name ~args:data ~t_ref:tls.thread_ref
      ~time_ns ~async_id:trace_id ();
    {
      span = 0L;
      trace_id;
      meta = Meta_map.(empty |> add key_async_data { name; flavor; data = [] });
    }

  let exit_manual_span (es : explicit_span) : unit =
    let { name; data; flavor = _ } = Meta_map.find_exn key_async_data es.meta in
    let out, tls = get_thread_output () in
    let time_ns = Time.now_ns () in

    FWrite.Event.Async_end.encode out ~name ~t_ref:tls.thread_ref ~time_ns
      ~args:data ~async_id:es.trace_id ()

  let add_data_to_manual_span (es : explicit_span) data =
    let m = Meta_map.find_exn key_async_data es.meta in
    m.data <- List.rev_append data m.data

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

  let name_process name : unit =
    let out, _tls = get_thread_output () in
    FWrite.Kernel_object.(encode out ~name ~ty:ty_process ~kid:pid ~args:[] ())

  let name_thread name : unit =
    let out, tls = get_thread_output () in
    FWrite.Kernel_object.(
      encode out ~name ~ty:ty_thread ~kid:tls.tid
        ~args:[ "process", `Kid pid ]
        ())

  let extension_event _ = ()
end

let create ~out () : collector =
  let buf_pool = Buf_pool.create () in
  let events = B_queue.create () in

  let bg_thread =
    Thread.create (Bg_thread.bg_thread ~buf_pool ~out ~events) ()
  in

  let st =
    {
      active = A.make true;
      buf_pool;
      bg_thread;
      events;
      span_id_gen = A.make 0;
      next_thread_ref = A.make 1;
      per_thread = Array.init 16 (fun _ -> A.make Int_map.empty);
    }
  in

  let _tick_thread = Thread.create (fun () -> Bg_thread.tick_thread events) in

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
