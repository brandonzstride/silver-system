module type S = sig
  type t
  val ( * ) : t -> t -> t
  val inverse : t -> t
  val int_equal : t -> int -> bool
  val int_compare : t -> int -> int
  val equal : t -> t -> bool
  val compare : t -> t -> int
  val of_int : int -> t (* does not handle negatives well *)
  val to_int : t -> int
  val n : int
  val all : t list
end

module Z2 : S
module Z3 : S
module Z4 : S 

(* Must call this _ because the Group is not used in signature *)
module Make (_ : sig
    val operation : [> `Multiplication | `Addition]
    val n : int
  end) : S