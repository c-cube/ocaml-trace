include Types
module A = Atomic_
module Collector = Collector

type collector = (module Collector.S)

(** Global collector. *)
let collector : collector option A.t = A.make None

let[@inline] enabled () =
  match A.get collector with
  | None -> false
  | Some _ -> true

let[@inline] enter_span ?__FUNCTION__ ~__FILE__ ~__LINE__ name : span =
  match A.get collector with
  | None -> Collector.dummy_span
  | Some (module C) -> C.enter_span ?__FUNCTION__ ~__FILE__ ~__LINE__ name

let[@inline] exit_span span : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.exit_span span

let with_span_collector_ (module C : Collector.S) ?__FUNCTION__ ~__FILE__
    ~__LINE__ name f =
  let sp = C.enter_span ?__FUNCTION__ ~__FILE__ ~__LINE__ name in
  match f sp with
  | x ->
    C.exit_span sp;
    x
  | exception exn ->
    let bt = Printexc.get_raw_backtrace () in
    C.exit_span sp;
    Printexc.raise_with_backtrace exn bt

let[@inline] with_span ?__FUNCTION__ ~__FILE__ ~__LINE__ name f =
  match A.get collector with
  | None ->
    (* fast path: no collector, no span *)
    f Collector.dummy_span
  | Some collector ->
    with_span_collector_ collector ?__FUNCTION__ ~__FILE__ ~__LINE__ name f

let[@inline] message ?__FUNCTION__ ~__FILE__ ~__LINE__ msg : unit =
  match A.get collector with
  | None -> ()
  | Some (module C) -> C.message ?__FUNCTION__ ~__FILE__ ~__LINE__ msg

let messagef ?__FUNCTION__ ~__FILE__ ~__LINE__ k =
  match A.get collector with
  | None -> ()
  | Some (module C) ->
    k (fun fmt ->
        Format.kasprintf
          (fun str -> C.message ?__FUNCTION__ ~__FILE__ ~__LINE__ str)
          fmt)

let setup_collector c : unit =
  while
    let cur = A.get collector in
    match cur with
    | Some _ -> invalid_arg "trace: collector already present"
    | None -> not (A.compare_and_set collector cur (Some c))
  do
    Domain_.relax ()
  done

let shutdown () =
  match A.exchange collector None with
  | None -> ()
  | Some (module C) -> C.shutdown ()

module Internal_ = struct
  module Atomic_ = Atomic_
end
