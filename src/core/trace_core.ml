include Types
module A = Atomic_
module Collector = Collector
module Meta_map = Meta_map
module Level = Level

type collector = (module Collector.S)

(* ## globals ## *)

(** Global collector. *)
let collector : collector option A.t = A.make None

(* default level for spans without a level *)
let default_level_ = A.make Level.Trace
let current_level_ = A.make Level.Trace

(* ## implementation ## *)

let data_empty_build_ () = []

let[@inline] enabled () =
  match A.get collector with
  | None -> false
  | Some _ -> true

let[@inline] get_default_level () = A.get default_level_
let[@inline] set_default_level l = A.set default_level_ l
let[@inline] set_current_level l = A.set current_level_ l
let[@inline] get_current_level () = A.get current_level_

let[@inline] check_level ?(level = A.get default_level_) () : bool =
  Level.leq level (A.get current_level_)

let with_span_collector_ (module C : Collector.S) ?__FUNCTION__ ~__FILE__
    ~__LINE__ ?(data = data_empty_build_) name f =
  let data = data () in
  C.with_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name f

let[@inline] with_span ?level ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name f =
  match A.get collector with
  | Some collector when check_level ?level () ->
    with_span_collector_ collector ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name
      f
  | _ ->
    (* fast path: no collector, no span *)
    f Collector.dummy_span

let[@inline] enter_span ?level ?__FUNCTION__ ~__FILE__ ~__LINE__
    ?(data = data_empty_build_) name : span =
  match A.get collector with
  | Some (module C) when check_level ?level () ->
    let data = data () in
    C.enter_span ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data name
  | _ -> Collector.dummy_span

let[@inline] exit_span sp : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.exit_span sp

let enter_explicit_span_collector_ (module C : Collector.S) ~parent ~flavor
    ?__FUNCTION__ ~__FILE__ ~__LINE__ ?(data = data_empty_build_) name :
    explicit_span =
  let data = data () in
  C.enter_manual_span ~parent ~flavor ~__FUNCTION__ ~__FILE__ ~__LINE__ ~data
    name

let[@inline] enter_manual_sub_span ~parent ?flavor ?level ?__FUNCTION__
    ~__FILE__ ~__LINE__ ?data name : explicit_span =
  match A.get collector with
  | Some coll when check_level ?level () ->
    enter_explicit_span_collector_ coll ~parent:(Some parent) ~flavor
      ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name
  | _ -> Collector.dummy_explicit_span

let[@inline] enter_manual_toplevel_span ?flavor ?level ?__FUNCTION__ ~__FILE__
    ~__LINE__ ?data name : explicit_span =
  match A.get collector with
  | Some coll when check_level ?level () ->
    enter_explicit_span_collector_ coll ~parent:None ~flavor ?__FUNCTION__
      ~__FILE__ ~__LINE__ ?data name
  | _ -> Collector.dummy_explicit_span

let[@inline] exit_manual_span espan : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.exit_manual_span espan

let[@inline] add_data_to_span sp data : unit =
  if data <> [] then (
    match A.get collector with
    | None -> ()
    | Some (module C) -> C.add_data_to_span sp data
  )

let[@inline] add_data_to_manual_span esp data : unit =
  if data <> [] then (
    match A.get collector with
    | None -> ()
    | Some (module C) -> C.add_data_to_manual_span esp data
  )

let message_collector_ (module C : Collector.S) ?span
    ?(data = data_empty_build_) msg : unit =
  let data = data () in
  C.message ?span ~data msg

let[@inline] message ?level ?span ?data msg : unit =
  match A.get collector with
  | Some coll when check_level ?level () ->
    message_collector_ coll ?span ?data msg
  | _ -> ()

let messagef ?level ?span ?data k =
  match A.get collector with
  | Some (module C) when check_level ?level () ->
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
  | _ -> ()

let counter_int ?level ?(data = data_empty_build_) name n : unit =
  match A.get collector with
  | Some (module C) when check_level ?level () ->
    let data = data () in
    C.counter_int ~data name n
  | _ -> ()

let counter_float ?level ?(data = data_empty_build_) name f : unit =
  match A.get collector with
  | Some (module C) when check_level ?level () ->
    let data = data () in
    C.counter_float ~data name f
  | _ -> ()

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
