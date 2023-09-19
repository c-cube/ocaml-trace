include Trace_core

let k_parent : explicit_span Lwt.key = Lwt.new_key ()

let[@inline never] with_span_lwt_real_ ?parent ?(force_toplevel = false)
    ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name f =
  let parent =
    match parent with
    | Some _ as p -> p
    | None -> Lwt.get k_parent
  in

  let espan =
    match parent, force_toplevel with
    | _, true | None, _ ->
      enter_manual_toplevel_span ~flavor:`Async ?__FUNCTION__ ~__FILE__
        ~__LINE__ ?data name
    | Some parent, _ ->
      enter_manual_sub_span ~parent ~flavor:`Async ?__FUNCTION__ ~__FILE__
        ~__LINE__ ?data name
  in

  Lwt.with_value k_parent (Some espan) (fun () ->
      let fut = f espan.span in
      Lwt.on_termination fut (fun () -> exit_manual_span espan);

      fut)

let[@inline] with_span_lwt ?parent ?force_toplevel ?__FUNCTION__ ~__FILE__
    ~__LINE__ ?data name f : _ Lwt.t =
  if enabled () then
    with_span_lwt_real_ ?parent ?force_toplevel ?__FUNCTION__ ~__FILE__
      ~__LINE__ ?data name f
  else
    f 0L

let[@inline never] with_span_real_ ?parent ?(force_toplevel = false)
    ?__FUNCTION__ ~__FILE__ ~__LINE__ ?data name f =
  let parent =
    match parent with
    | Some _ as p -> p
    | None -> Lwt.get k_parent
  in

  let espan =
    match parent, force_toplevel with
    | _, true | None, _ ->
      enter_manual_toplevel_span ~flavor:`Async ?__FUNCTION__ ~__FILE__
        ~__LINE__ ?data name
    | Some parent, _ ->
      enter_manual_sub_span ~parent ~flavor:`Async ?__FUNCTION__ ~__FILE__
        ~__LINE__ ?data name
  in

  Lwt.with_value k_parent (Some espan) (fun () ->
      Fun.protect
        (fun () -> f espan.span)
        ~finally:(fun () -> exit_manual_span espan))

let[@inline] with_span ?parent ?force_toplevel ?__FUNCTION__ ~__FILE__ ~__LINE__
    ?data name f =
  if enabled () then
    with_span_real_ ?parent ?force_toplevel ?__FUNCTION__ ~__FILE__ ~__LINE__
      ?data name f
  else
    f 0L
