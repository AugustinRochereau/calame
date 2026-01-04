(** lib/machine.mli *)

(** Calame machine

    Une machine calame est une structure dans laquelle :
    - un espace est tenu,
    - une observation est définie,
    - des stabilisations peuvent s'accumuler.

    Aucun modèle d'exécution n'est prescrit.
*)

open Obs
open Stab

(** Type de machines sur un espace ['x] et valeurs observées ['a]. *)

type ('x, 'a) t

(** --- Construction ---

    Crée une machine à partir de :
    - Un espace initial,
    - Une observation initiale,
    - Une stabilisation initiale.
*)

val make :
  space:'x ->
  obs:('x, 'a) obs ->
  stab:'x stab ->
  ('x, 'a) t

(** --- Accesseurs ---

    Accès aux composants de la machine.
*)

val space : ('x, 'a) t -> 'x

val obs : ('x, 'a) t -> ('x, 'a) obs

val stab : ('x, 'a) t -> 'x stab

(** --- Transformations ---

    Actualise la machine en : 
    - changeant l'observation (point de vue),
    - accumulant des stabilisations. 
*)

val with_obs :
  ('x, 'a) diff ->
  ('x, 'a) t ->
  ('x, 'a) t

val with_stab :
  'x stab ->
  ('x, 'a) t ->
  ('x, 'a) t
