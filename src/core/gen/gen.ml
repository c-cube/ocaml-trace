let atomic_pre_412 =
  {|
type 'a t = { mutable x: 'a }

let[@inline] make x = { x }
let[@inline] get { x } = x
let[@inline] set r x = r.x <- x

let[@inline never] exchange r x =
  (* atomic *)
  let y = r.x in
  r.x <- x;
  (* atomic *)
  y

let[@inline never] compare_and_set r seen v =
  (* atomic *)
  if r.x == seen then (
    r.x <- v;
    (* atomic *)
    true
  ) else
    false

let[@inline never] fetch_and_add r x =
  (* atomic *)
  let v = r.x in
  r.x <- x + r.x;
  (* atomic *)
  v

let[@inline never] incr r =
  (* atomic *)
  r.x <- 1 + r.x
(* atomic *)

let[@inline never] decr r =
  (* atomic *)
  r.x <- r.x - 1
  (* atomic *)

|}

let atomic_post_412 = {|
include Atomic
|}

let type_ml_pre_510 =
  {|
(* Type equality witness *)

type (_, _) eq = Equal: ('a, 'a) eq

(* Type identifiers *)

module Id = struct
  type _ id = ..
  module type ID = sig
    type t
    type _ id += Id : t id
  end

  type 'a t = (module ID with type t = 'a)

  let make (type a) () : a t =
    (module struct type t = a type _ id += Id : t id end)

  let[@inline] uid (type a) ((module A) : a t) =
    Obj.Extension_constructor.id (Obj.Extension_constructor.of_val A.Id)

  let provably_equal
      (type a b) ((module A) : a t) ((module B) : b t) : (a, b) eq option
    =
    match A.Id with B.Id -> Some Equal | _ -> None
end
|}

let type_mli_pre_510 =
  {|
type (_, _) eq = Equal: ('a, 'a) eq (** *)
(** The purpose of [eq] is to represent type equalities that may not otherwise
    be known by the type checker (e.g. because they may depend on dynamic data).

    A value of type [(a, b) eq] represents the fact that types [a] and [b] are
    equal.

    If one has a value [eq : (a, b) eq] that proves types [a] and [b] are equal,
    one can use it to convert a value of type [a] to a value of type [b] by
    pattern matching on [Equal]:
    {[
      let cast (type a) (type b) (Equal : (a, b) Type.eq) (a : a) : b = a
    ]}

    At runtime, this function simply returns its second argument unchanged.
*)

(** {1:identifiers Type identifiers} *)

(** Type identifiers.

    A type identifier is a value that denotes a type. Given two type
    identifiers, they can be tested for {{!Id.provably_equal}equality} to
    prove they denote the same type. Note that:

    - Unequal identifiers do not imply unequal types: a given type can be
      denoted by more than one identifier.
    - Type identifiers can be marshalled, but they get a new, distinct,
      identity on unmarshalling, so the equalities are lost.

    See an {{!Id.example}example} of use. *)
module Id : sig

  (** {1:ids Type identifiers} *)

  type 'a t
  (** The type for identifiers for type ['a]. *)

  val make : unit -> 'a t
  (** [make ()] is a new type identifier. *)

  val uid : 'a t -> int
  (** [uid id] is a runtime unique identifier for [id]. *)

  val provably_equal : 'a t -> 'b t -> ('a, 'b) eq option
  (** [provably_equal i0 i1] is [Some Equal] if identifier [i0] is equal
      to [i1] and [None] otherwise. *)
end
|}

let type_ml_post_510 = {|
include Type
|}

let type_mli_post_510 = {|
include module type of Type
|}

let p_version s = Scanf.sscanf s "%d.%d" (fun x y -> x, y)

let () =
  let atomic = ref false in
  let type_ml = ref false in
  let type_mli = ref false in
  let ocaml = ref Sys.ocaml_version in
  Arg.parse
    [
      "--atomic", Arg.Set atomic, " atomic";
      "--type-ml", Arg.Set type_ml, " type.ml";
      "--type-mli", Arg.Set type_mli, " type.mli";
      "--ocaml", Arg.Set_string ocaml, " set ocaml version";
    ]
    ignore "";

  let major, minor = p_version !ocaml in

  if !atomic then (
    let code =
      if (major, minor) < (4, 12) then
        atomic_pre_412
      else
        atomic_post_412
    in
    print_endline code
  ) else if !type_ml then (
    let code =
      if (major, minor) < (5, 10) then
        type_ml_pre_510
      else
        type_ml_post_510
    in
    print_endline code
  ) else if !type_mli then (
    let code =
      if (major, minor) < (5, 10) then
        type_mli_pre_510
      else
        type_mli_post_510
    in
    print_endline code
  )
