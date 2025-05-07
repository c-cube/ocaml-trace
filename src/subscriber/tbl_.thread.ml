module T = Hashtbl.Make (struct
  include Int64

  let hash = Hashtbl.hash
end)

type 'v t = {
  tbl: 'v T.t;
  lock: Mutex.t;
}

let create () : _ t = { tbl = T.create 32; lock = Mutex.create () }

let find_exn self k =
  Mutex.lock self.lock;
  try
    let v = T.find self.tbl k in
    Mutex.unlock self.lock;
    v
  with e ->
    Mutex.unlock self.lock;
    raise e

let remove self k =
  Mutex.lock self.lock;
  T.remove self.tbl k;
  Mutex.unlock self.lock

let add self k v =
  Mutex.lock self.lock;
  T.replace self.tbl k v;
  Mutex.unlock self.lock

let to_list self : _ list =
  Mutex.lock self.lock;
  let l = T.fold (fun k v l -> (k, v) :: l) self.tbl [] in
  Mutex.unlock self.lock;
  l
