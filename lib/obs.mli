(** lib/obs.mli *)

(** --- Espace ---

    Un type ['x] est un espace.
*)

(** --- Observations ---
 
    Une observation est un point de vue d'un espace ['x],
    produisant une valeur de type ['a].

    Les observations ne modifient pas l'espace.
*)

type ('x, 'a) obs = 'x -> 'a

(** --- Changements de point de vue ---

   Une [diff] transforme une observation en une autre
   sur le même espace - i.e., le même type 'observé' -.

   Une [diff] ne modifie pas l'espace, seulement la manière dont il est perçu.
*)

type ('x, 'a) diff = ('x, 'a) obs -> ('x, 'a) obs
