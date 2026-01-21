let run () =
  Trace.set_process_name "main";
  Trace.set_thread_name "t1";

  let n = ref 0 in

  for _i = 1 to 50 do
    Trace.with_span ~__FILE__ ~__LINE__ "outer.loop" @@ fun _sp ->
    let pseudo_async_sp =
      Trace.enter_span ~parent:None ~__FILE__ ~__LINE__ "fake_sleep"
    in

    for _j = 2 to 5 do
      incr n;
      Trace.with_span ~__FILE__ ~__LINE__ "inner.loop" @@ fun _sp ->
      Trace.messagef (fun k -> k "hello %d %d" _i _j);
      Trace.message "world";
      Trace.counter_int "n" !n;

      Trace.add_data_to_span _sp [ "i", `Int _i ];

      if _j = 2 then (
        Trace.add_data_to_span _sp [ "j", `Int _j ];
        let _sp =
          Trace.enter_span ~parent:(Some pseudo_async_sp)
            ~flavor:
              (if _i mod 3 = 0 then
                 `Sync
               else
                 `Async)
            ~__FILE__ ~__LINE__ "sub-sleep"
        in

        (* fake micro sleep *)
        Thread.delay 0.005;
        Trace.exit_span _sp
      ) else if _j = 3 then (
        (* pretend some task finished. Note that this is not well scoped wrt other spans. *)
        Trace.add_data_to_span pseudo_async_sp [ "slept", `Bool true ];
        Trace.exit_span pseudo_async_sp
      )
    done
  done

let to_hex (s : string) : string =
  let i_to_hex (i : int) =
    if i < 10 then
      Char.chr (i + Char.code '0')
    else
      Char.chr (i - 10 + Char.code 'a')
  in

  let res = Bytes.create (2 * String.length s) in
  for i = 0 to String.length s - 1 do
    let n = Char.code (String.get s i) in
    Bytes.set res (2 * i) (i_to_hex ((n land 0xf0) lsr 4));
    Bytes.set res ((2 * i) + 1) (i_to_hex (n land 0x0f))
  done;
  Bytes.unsafe_to_string res

let () =
  Trace_fuchsia.Internal_.mock_all_ ();
  let buf = Buffer.create 32 in
  let exporter = Trace_fuchsia.Exporter.of_buffer buf in
  Trace_fuchsia.with_setup ~out:(`Exporter exporter) () run;
  exporter.close ();

  let data = Buffer.contents buf in
  (let oc = open_out_bin "t1.fxt" in
   output_string oc data;
   close_out_noerr oc);

  (* print_endline (to_hex data); *)
  Printf.printf "data: %d bytes\n" (String.length data);
  flush stdout
