module A = Trace_core.Internal_.Atomic_
open Trace_core

let ( let@ ) = ( @@ )

type span += Span_tracked of (* id *) int * span

type unclosed_spans = {
  num: int;
  by_name: (string * int) list;
}

type out =
  [ `Out of out_channel
  | `Call of unclosed_spans -> unit
  ]

open struct
  module Tbl = Hashtbl.Make (struct
    type t = int

    let equal = Stdlib.( = )
    let hash = Hashtbl.hash
  end)

  type 'state st = {
    mutex: Mutex.t;
    tbl_open_spans: string Tbl.t;
    gen_id: int A.t;
    state: 'state;
    cbs: 'state Collector.Callbacks.t;  (** underlying callbacks *)
    out: out;
  }

  let create_st ~state ~cbs ~out () : _ st =
    {
      mutex = Mutex.create ();
      tbl_open_spans = Tbl.create 32;
      gen_id = A.make 0;
      state;
      cbs;
      out;
    }

  let with_mutex mut f =
    Mutex.lock mut;
    Fun.protect f ~finally:(fun () -> Mutex.unlock mut)

  let enter_span (self : _ st) ~__FUNCTION__ ~__FILE__ ~__LINE__ ~level ~params
      ~data ~parent name : span =
    let span =
      self.cbs.enter_span self.state ~__FUNCTION__ ~__FILE__ ~__LINE__ ~level
        ~params ~data ~parent name
    in
    let id = A.fetch_and_add self.gen_id 1 in
    (let@ () = with_mutex self.mutex in
     Tbl.add self.tbl_open_spans id name);
    Span_tracked (id, span)

  let exit_span (self : _ st) span =
    match span with
    | Span_tracked (id, span) ->
      (let@ () = with_mutex self.mutex in
       Tbl.remove self.tbl_open_spans id);
      self.cbs.exit_span self.state span
    | _ -> self.cbs.exit_span self.state span

  let add_data_to_span (self : _ st) span data =
    match span with
    | Span_tracked (_, span) -> self.cbs.add_data_to_span self.state span data
    | _ -> self.cbs.add_data_to_span self.state span data

  let emit (self : _ st) (us : unclosed_spans) =
    assert (us.by_name <> []);
    match self.out with
    | `Call f -> f us
    | `Out out ->
      Printf.fprintf out "trace: warning: %d spans were not closed\n" us.num;
      List.iter
        (fun (name, n) ->
          Printf.fprintf out "  span %S was not closed (%d occurrences)\n" name
            n)
        us.by_name;
      flush out

  let print_non_closed_spans_warning (self : _ st) =
    let module Str_map = Map.Make (String) in
    let@ () = with_mutex self.mutex in

    let num = Tbl.length self.tbl_open_spans in
    if num > 0 then (
      let names_with_count =
        Tbl.fold
          (fun _id name m ->
            Str_map.add name
              (1 + try Str_map.find name m with Not_found -> 0)
              m)
          self.tbl_open_spans Str_map.empty
      in
      let unclosed_spans =
        {
          num;
          by_name =
            Str_map.fold (fun name id l -> (name, id) :: l) names_with_count []
            |> List.sort Stdlib.compare;
        }
      in
      emit self unclosed_spans
    )

  let message self ~level ~params ~data ~span msg =
    let span =
      match span with
      | Some (Span_tracked (_, sp)) -> Some sp
      | _ -> span
    in
    self.cbs.message self.state ~level ~params ~data ~span msg

  let metric self ~level ~params ~data name v =
    self.cbs.metric self.state ~level ~params ~data name v

  let init (self : _ st) = self.cbs.init self.state

  let shutdown (self : _ st) : unit =
    print_non_closed_spans_warning self;
    self.cbs.shutdown self.state

  let extension self ~level ev = self.cbs.extension self.state ~level ev

  let track_callbacks : _ st Collector.Callbacks.t =
    {
      enter_span;
      exit_span;
      add_data_to_span;
      message;
      metric;
      init;
      shutdown;
      extension;
    }
end

let track ?(on_lingering_spans = `Out stderr) (c : Collector.t) : Collector.t =
  match c with
  | C_none -> C_none
  | C_some (st, cbs) ->
    let st = create_st ~state:st ~cbs ~out:on_lingering_spans () in
    C_some (st, track_callbacks)
