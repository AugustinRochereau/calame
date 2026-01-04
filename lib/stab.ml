(** lib/stab.ml *)

type 'x stab = 'x -> 'x

let id x = x

let compose f g =
  fun x -> f (g x)
