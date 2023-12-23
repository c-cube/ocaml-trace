open Ppxlib

let location_errorf ~loc fmt =
  Format.kasprintf
    (fun err ->
      raise (Ocaml_common.Location.Error (Ocaml_common.Location.error ~loc err)))
    fmt

(** {2 let expression} *)

let expand_let ~ctxt (name : string) body =
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  Ast_builder.Default.(
    [%expr
      let _trace_span =
        Trace_core.enter_span ~__FILE__ ~__LINE__ [%e estring ~loc name]
      in
      try
        let res = [%e body] in
        Trace_core.exit_span _trace_span;
        res
      with exn ->
        Trace_core.exit_span _trace_span;
        raise exn])

let extension_let =
  Extension.V3.declare "trace" Extension.Context.expression
    (let open! Ast_pattern in
    single_expr_payload
      (pexp_let nonrecursive
         (value_binding
            ~pat:(ppat_construct (lident (string "()")) none)
            ~expr:(estring __)
         ^:: nil)
         __))
    expand_let

let rule_let = Ppxlib.Context_free.Rule.extension extension_let

(** {2 Toplevel binding} *)

let expand_top_let ~ctxt rec_flag (vbs : _ list) =
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  Ast_builder.Default.(
    (* go in functions, and add tracing around the body *)
    let rec push_into_fun (e : expression) : expression =
      match e.pexp_desc with
      | Pexp_fun (lbl, lbl_expr, pat, body) ->
        pexp_fun ~loc:e.pexp_loc lbl lbl_expr pat @@ push_into_fun body
      | _ ->
        [%expr
          let _trace_span =
            Trace_core.enter_span ~__FILE__ ~__LINE__ __FUNCTION__
          in
          try
            let res = [%e e] in
            Trace_core.exit_span _trace_span;
            res
          with exn ->
            Trace_core.exit_span _trace_span;
            raise exn]
    in

    let tr_vb (vb : value_binding) : value_binding =
      let expr = push_into_fun vb.pvb_expr in
      { vb with pvb_expr = expr }
    in

    let vbs = List.map tr_vb vbs in
    pstr_value ~loc rec_flag vbs)

let extension_top_let =
  Extension.V3.declare "trace" Extension.Context.structure_item
    (let open! Ast_pattern in
    pstr (pstr_value __ __ ^:: nil))
    expand_top_let

let rule_top_let = Ppxlib.Context_free.Rule.extension extension_top_let

let () =
  Driver.register_transformation ~rules:[ rule_let; rule_top_let ] "ppx_trace"
