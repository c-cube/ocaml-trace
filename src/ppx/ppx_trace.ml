open Ppxlib

let location_errorf ~loc fmt =
  Format.kasprintf
    (fun err ->
      raise (Ocaml_common.Location.Error (Ocaml_common.Location.error ~loc err)))
    fmt

(** {2 let expression} *)

let expand_let ~ctxt (var : [ `Var of label loc | `Unit ]) (name : string) body
    =
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  Ast_builder.Default.(
    let var_pat =
      match var with
      | `Var v -> ppat_var ~loc:v.loc v
      | `Unit -> ppat_var ~loc { loc; txt = "_trace_span" }
    in
    let var_exp =
      match var with
      | `Var v -> pexp_ident ~loc:v.loc { txt = lident v.txt; loc = v.loc }
      | `Unit -> [%expr _trace_span]
    in
    [%expr
      let [%p var_pat] =
        Trace_core.enter_span ~__FILE__ ~__LINE__ [%e estring ~loc name]
      in
      try
        let res = [%e body] in
        Trace_core.exit_span [%e var_exp];
        res
      with exn ->
        Trace_core.exit_span [%e var_exp];
        raise exn])

let extension_let =
  Extension.V3.declare "trace" Extension.Context.expression
    (let open! Ast_pattern in
     single_expr_payload
       (pexp_let nonrecursive
          (value_binding
             ~pat:
               (let pat_var = ppat_var __' |> map ~f:(fun f v -> f (`Var v)) in
                let pat_unit =
                  as__ @@ ppat_construct (lident (string "()")) none
                  |> map ~f:(fun f _ -> f `Unit)
                in
                alt pat_var pat_unit)
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
          match [%e e] with
          | res ->
            Trace_core.exit_span _trace_span;
            res
          | exception exn ->
            let bt = Printexc.get_raw_backtrace () in
            Trace_core.exit_span _trace_span;
            Printexc.raise_with_backtrace exn bt]
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
