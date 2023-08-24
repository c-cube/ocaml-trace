(* Type identifiers, can be deleted once OCaml >= 5.1 is required *)
module Type = struct
  type (_, _) eq = Equal : ('a, 'a) eq

  module Id = struct
    type _ id = ..

    module type ID = sig
      type t
      type _ id += Id : t id
    end

    type 'a t = (module ID with type t = 'a)

    let make (type a) () : a t =
      (module struct
        type t = a
        type _ id += Id : t id
      end)

    let provably_equal (type a b) ((module A) : a t) ((module B) : b t) :
        (a, b) eq option =
      match A.Id with
      | B.Id -> Some Equal
      | _ -> None

    let uid (type a) ((module A) : a t) =
      Obj.Extension_constructor.id (Obj.Extension_constructor.of_val A.Id)
  end
end

module Key = struct
  type 'a t = 'a Type.Id.t

  let create = Type.Id.make
  let id = Type.Id.uid

  let equal a b =
    match Type.Id.provably_equal a b with
    | None -> false
    | Some Type.Equal -> true
end

type pair = Pair : 'a Key.t * 'a -> pair

module M = Map.Make (Int)

type t = pair M.t

let empty = M.empty
let mem k t = M.mem (Key.id k) t

let find_exn (type a) (k : a Key.t) t : a =
  let (Pair (k', v)) = M.find (Key.id k) t in
  match Type.Id.provably_equal k k' with
  | None -> assert false
  | Some Type.Equal -> v

let find k t = try Some (find_exn k t) with Not_found -> None
let add k v t = M.add (Key.id k) (Pair (k, v)) t
let remove k t = M.remove (Key.id k) t
let cardinal = M.cardinal
let length = cardinal
let iter f t = M.iter (fun _ p -> f p) t
let to_list t = M.fold (fun _ p l -> p :: l) t []
let add_pair_ (Pair (k, v)) t = add k v t
let add_list t l = List.fold_right add_pair_ l t
let of_list l = add_list empty l
