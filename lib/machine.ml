(** lib/machine.ml *)

open Obs
open Stab

(* Représentation d'une machine Calame. *)

type ('x, 'a) t = {
  space : 'x;
  obs   : ('x, 'a) obs;
  stab  : 'x stab;
}

(* --- Construction --- *)

let make ~space ~obs ~stab =
  { space; obs; stab }

(* --- Accesseurs --- *)

let space m = m.space

let obs m = m.obs

let stab m = m.stab

(* --- Transformations --- *)

let with_obs diff m =
  { m with obs = diff m.obs }

let with_stab stab' m =
  { m with stab = compose stab' m.stab }
