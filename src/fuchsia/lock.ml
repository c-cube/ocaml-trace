type 'a t = {
  mutex: Mutex.t;
  mutable content: 'a;
}

let create content : _ t = { mutex = Mutex.create (); content }

let with_ (self : _ t) f =
  Mutex.lock self.mutex;
  try
    let x = f self.content in
    Mutex.unlock self.mutex;
    x
  with e ->
    let bt = Printexc.get_raw_backtrace () in
    Mutex.unlock self.mutex;
    Printexc.raise_with_backtrace e bt

let[@inline] update self f = with_ self (fun x -> self.content <- f x)

let[@inline] update_map l f =
  with_ l (fun x ->
      let x', y = f x in
      l.content <- x';
      y)

let[@inline] set_while_locked (self : 'a t) (x : 'a) = self.content <- x
