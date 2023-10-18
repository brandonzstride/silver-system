(*
  File: cube.mli
  Module purpose: efficiently represent a whole cube.
  Status: in progress.

  Detailed description:
    This module will represent a cube in some phase of the solving algorithm,
    and it supports moves and symmetries on the cube. Such actions will
    be efficient and will use memoized versions of the coordinates.

    The cube can be in Phase 1 or Phase 2 of the solving algorithm. This module
    helps the user recognize which phase it is in and if the cube has reached
    the goal state.

    This currently does not support choosing non-symmetry coordinates to
    represent the cube during the solving.

  Expected usage:
    The solver creates a cube from a permutation to efficiently make moves and
    check for solvedness. The solver should handle converting back to a

  Other comments:
    Might support functionality without memoization to compare speed.

    Currently shares some responsibility with the pruning table because these
    cubes convert to and from ranks.
*)

module type S =
  sig
    type t
    val is_goal_state : t -> bool
    (* discards information about some parts of the cube *)
    val of_perm : Perm.t -> (t, string) result 
    val to_perm : t -> Perm.t (* for testing purposes *)
    (* gets rank as it's expected to be in the pruning table *)
    val of_rank : int -> t option
    val to_rank : t -> int
  end

(* Supports Twist and Flip_UD_slice coordinates *)
module Phase1 : S  

(* Supports Edge_perm, Corner_perm, and UD_slice_perm coordinates *)
(* module Phase2 : S *)
