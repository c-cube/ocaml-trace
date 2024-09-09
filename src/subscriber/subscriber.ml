(** A trace subscriber *)
type t =
  | Sub : {
      st: 'st;
      callbacks: 'st Callbacks.t;
    }
      -> t

let dummy : t = Sub { st = (); callbacks = Callbacks.dummy () }

(* TODO:
   let multiplex (l : t list) : t =
     match l with
     | [] -> dummy
     | [ s ] -> s
     | _ ->
       let module M = struct
         type st = t list

         let on_init l ~time_ns =
           List.iter
             (fun (Sub { st; callbacks = (module CB) }) -> CB.on_init st ~time_ns)
             l

         let on_shutdown _ ~time_ns:_ = ()
         let on_tick _ = ()
         let on_name_thread _ ~time_ns:_ ~tid:_ ~name:_ = ()
         let on_name_process _ ~time_ns:_ ~tid:_ ~name:_ = ()
         let on_message _ ~time_ns:_ ~tid:_ ~span:_ ~data:_ _msg = ()
         let on_counter _ ~time_ns:_ ~tid:_ ~data:_ ~name:_ _v = ()

         let on_enter_span _ ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_ ~time_ns:_
             ~tid:_ ~data:_ ~name:_ _sp =
           ()

         let on_exit_span _ ~time_ns:_ ~tid:_ _ = ()
         let on_add_data _ ~data:_ _sp = ()

         let on_enter_manual_span _ ~__FUNCTION__:_ ~__FILE__:_ ~__LINE__:_
             ~time_ns:_ ~tid:_ ~parent:_ ~data:_ ~name:_ ~flavor:_ ~trace_id:_ _sp
             =
           ()

         let on_exit_manual_span _ ~time_ns:_ ~tid:_ ~name:_ ~data:_ ~flavor:_
             ~trace_id:_ _ =
           ()
       end in
       Sub { st = l; callbacks = (module M) }
*)
