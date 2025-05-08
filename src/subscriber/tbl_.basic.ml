module T = Hashtbl.Make (struct
  include Int64

  let hash = Hashtbl.hash
end)

type 'v t = 'v T.t

let create () : _ t = T.create 32
let find_exn = T.find
let remove = T.remove
let add = T.replace
let to_list self : _ list = T.fold (fun k v l -> (k, v) :: l) self []
