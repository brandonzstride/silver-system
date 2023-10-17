(*
  File: lookup_table.mli
  Module purpose: data structure for fast mappings on ranked types.
  Status: complete.

  Detailed description:
    A lookup table is a data structure that allows fast lookup of ranked types.
    They use arrays, but the mutation is behind-the-scenes and the table is
    only mutated upon creation. The user can treat the table as if it is
    immutable.

  Expected usage:
    * Map coordinate and move to a new coordinate
    * Map coordinate and symmetry to new coordinate
    * Map representative symmetry coordinate and move to new symmetry coordinate
    * Map two symmetries to a new symmetry
    * Store pruning tables.

    The domain must have a `to_rank` function that takes an element of the domain
    to a unique integer.

  Dependencies:
    None

*)

module type Key =
  sig
    type t
    val to_rank : t -> int
  end

module type Return_type =
  sig
    type t [@@deriving sexp]
  end

module One_dim :
  sig
    module Make (Key : Key) (R : Return_type) :
      sig
        type t
        val from_file : string -> t
        val to_file : t -> string -> unit
        val of_list : R.t list -> t
        (* Given list *must* be sorted by rank. This is not asserted, and it is up to the user to assert *)
        val create : Key.t list -> f:(Key.t -> R.t) -> t
        val lookup : t -> Key.t -> R.t
        val get_size : t -> int
      end
  end

module Two_dim :
  sig
    module Make (Key1 : Key) (Key2 : Key) (R : Return_type) :
      sig
        type t
        val from_file : string -> t
        val to_file : t -> string -> unit
        (* Given lists *must* be sorted by rank. This is not asserted, and it is up to the user to assert *)
        val create : ?n1:int -> ?n2:int -> Key1.t list -> Key2.t list -> f:(Key1.t -> Key2.t -> R.t) -> t
        val lookup : t -> Key1.t -> Key2.t -> R.t
        val get_size : t -> int
      end
  end