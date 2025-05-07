module H = Picos_aux_htbl

module Key = struct
  include Int64

  let hash = Hashtbl.hash
end

type 'v t = (int64, 'v) H.t

let create () : _ t = H.create ~hashed_type:(module Key) ()
let find_exn = H.find_exn
let[@inline] remove self k = ignore (H.try_remove self k : bool)

let[@inline] add self k v =
  if not (H.try_add self k v) then ignore (H.try_set self k v)

let[@inline] to_list self = H.to_seq self |> List.of_seq
