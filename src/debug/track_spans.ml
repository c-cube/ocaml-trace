open Trace_core

let spf = Printf.sprintf
let ( let@ ) = ( @@ )

type unclosed_spans = {
  num: int;
  by_name: (string * int) list;
}

type out =
  [ `Out of out_channel
  | `Call of unclosed_spans -> unit
  ]

module type TRACKED_SPAN = sig
  include Hashtbl.HashedType

  val of_span : Trace_core.span -> t option
  val name : t -> string
end

module Make_cbs (X : sig
  module T_span : TRACKED_SPAN

  type st

  val cbs : st Collector.Callbacks.t
  val out : out
end) =
struct
  module Tbl = Hashtbl.Make (X.T_span)

  let mutex = Mutex.create ()
  let tbl_open_spans : unit Tbl.t = Tbl.create 32

  let with_mutex mut f =
    Mutex.lock mut;
    Fun.protect f ~finally:(fun () -> Mutex.unlock mut)

  let enter_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~params ~data ~parent name
      : span =
    let span =
      X.cbs.enter_span st ~__FUNCTION__ ~__FILE__ ~__LINE__ ~params ~data
        ~parent name
    in

    (match X.T_span.of_span span with
    | None -> ()
    | Some t_span ->
      let@ () = with_mutex mutex in
      Tbl.add tbl_open_spans t_span ());
    span

  let exit_span st span =
    (match X.T_span.of_span span with
    | None -> ()
    | Some t_span ->
      let@ () = with_mutex mutex in
      Tbl.remove tbl_open_spans t_span);
    X.cbs.exit_span st span

  let emit (us : unclosed_spans) =
    assert (us.by_name <> []);
    match X.out with
    | `Call f -> f us
    | `Out out ->
      Printf.fprintf out "trace: warning: %d spans were not closed" us.num;
      List.iter
        (fun (name, n) ->
          Printf.fprintf out "  span %S was not closed (%d occurrences)" name n)
        us.by_name;
      flush out

  let print_non_closed_spans_warning () =
    let module Str_map = Map.Make (String) in
    let@ () = with_mutex mutex in

    let num = Tbl.length tbl_open_spans in
    if num > 0 then (
      let names_with_count =
        Tbl.fold
          (fun span () m ->
            let name = X.T_span.name span in
            Str_map.add name
              (1 + try Str_map.find name m with Not_found -> 0)
              m)
          tbl_open_spans Str_map.empty
      in
      let unclosed_spans =
        { num; by_name = Str_map.to_list names_with_count }
      in
      emit unclosed_spans
    )

  let shutdown st : unit =
    print_non_closed_spans_warning ();
    X.cbs.shutdown st

  let new_callbacks : _ Collector.Callbacks.t =
    { X.cbs with enter_span; exit_span; shutdown }
end

let track_ (type state) ~(out : out) (module T : TRACKED_SPAN) (st : state)
    (cbs : state Collector.Callbacks.t) : Collector.t =
  let module CBS = Make_cbs (struct
    module T_span = T

    type st = state

    let cbs = cbs
    let out = out
  end) in
  C_some (st, CBS.new_callbacks)

let track ?(on_lingering_spans = `Out stderr) (module T : TRACKED_SPAN)
    (c : Collector.t) : Collector.t =
  match c with
  | C_none -> C_none
  | C_some (st, cbs) -> track_ ~out:on_lingering_spans (module T) st cbs
