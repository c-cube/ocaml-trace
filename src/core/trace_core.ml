include Types
module A = Atomic_
module Collector = Collector
module Meta_map = Meta_map

type collector = (module Collector.S)

(** Global collector. *)
let collector : collector option A.t = A.make None

let[@inline] enabled () =
  match A.get collector with
  | None -> false
  | Some _ -> true

let with_span_collector_ (module C : Collector.S) ?__FUNCTION__ ~__FILE__
    ~__LINE__ ?(data = fun () -> []) name f =
  let data = data () in
  C.with_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name f

let[@inline] with_span ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name f =
  match A.get collector with
  | None ->
    (* fast path: no collector, no span *)
    f Collector.dummy_span
  | Some collector ->
    with_span_collector_ collector ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name
      f

let enter_explicit_span_collector_ (module C : Collector.S) ~parent
    ?__FUNCTION__ ~__FILE__ ~__LINE__ ?(data = fun () -> []) name :
    explicit_span =
  let data = data () in
  C.enter_manual_span ~parent ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name

let[@inline] enter_manual_sub_span ~parent ?__FUNCTION__ ~__FILE__ ~__LINE__
    ?data name : explicit_span =
  match A.get collector with
  | None -> Collector.dummy_explicit_span
  | Some coll ->
    enter_explicit_span_collector_ coll ~parent:(Some parent) ?__FUNCTION__
      ~__FILE__ ~__LINE__ ?data name

let[@inline] enter_manual_toplevel_span ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data
    name : explicit_span =
  match A.get collector with
  | None -> Collector.dummy_explicit_span
  | Some coll ->
    enter_explicit_span_collector_ coll ~parent:None ?__FUNCTION__ ~__FILE__
      ~__LINE__ ?data name

let[@inline] exit_manual_span espan : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.exit_manual_span espan

let message_collector_ (module C : Collector.S) ?span ?(data = fun () -> []) msg
    : unit =
  let data = data () in
  C.message ?span ~data msg

let[@inline] message ?span ?data msg : unit =
  match A.get collector with
  | None -> ()
  | Some coll -> message_collector_ coll ?span ?data msg

let messagef ?span ?data k =
  match A.get collector with
  | None -> ()
  | Some (module C) ->
    k (fun fmt ->
        Format.kasprintf
          (fun str ->
            let data =
              match data with
              | None -> []
              | Some f -> f ()
            in
            C.message ?span ~data str)
          fmt)

let counter_int name n : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.counter_int name n

let counter_float name f : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.counter_float name f

let set_thread_name name : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.name_thread name

let set_process_name name : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.name_process name

let setup_collector c : unit =
  while
    let cur = A.get collector in
    match cur with
    | Some _ -> invalid_arg "trace: collector already present"
    | None -> not (A.compare_and_set collector cur (Some c))
  do
    ()
  done

let shutdown () =
  match A.exchange collector None with
  | None -> ()
  | Some (module C) -> C.shutdown ()

module Internal_ = struct
  module Atomic_ = Atomic_
end
