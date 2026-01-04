(** lib/stab.mli *)

(** Stabilisations d'un espace.

    Une stabilisation est une transformation interne d'un espace ['x].

    Les stabilisations agissent sur l'espace, et ne donnent pas
    de manière privilégiée d'observer.
*)

(** --- Stabilisations ---

    Une stabilisation est un endomorphisme d'un espace.
*)

type 'x stab = 'x -> 'x

(** --- Structure algébrique ---

    Les stabilisations forment un monoïde sous la composition.

    - L'identité sur ['x] laisse l'espace inchangé.
    - Les stabilisations peuvent être composées séquentiellement.

    Cette structure permet aux stabilisations de s'accumuler,
    s'arranger, se rejouer ou s'instrumenter.
*)

val id : 'x stab

val compose : 'x stab -> 'x stab -> 'x stab
