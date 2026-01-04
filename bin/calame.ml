(** bin/calame.ml *)

(* Calame — REPL sur un espace textuel avec curseur *)

open Calame

(* -------------------------------------------------------------------------- *)
(* Espace                                                                     *)
(* -------------------------------------------------------------------------- *)

type x = string * int
(* texte, position du curseur *)

let empty : x = ("", 0)

let clamp_cursor (s, c) =
  let len = String.length s in
  let c' = max 0 (min c len) in
  (s, c')

(* -------------------------------------------------------------------------- *)
(* Observation                                                                *)
(* -------------------------------------------------------------------------- *)

let render : (x, string) Obs.obs =
  fun (s, c) ->
    let c = max 0 (min c (String.length s)) in
    let left  = String.sub s 0 c in
    let right = String.sub s c (String.length s - c) in
    left ^ "|" ^ right

(* -------------------------------------------------------------------------- *)
(* Stabilisations                                                             *)
(* -------------------------------------------------------------------------- *)

let insert (txt : string) : x Stab.stab =
  fun (s, c) ->
    let left  = String.sub s 0 c in
    let right = String.sub s c (String.length s - c) in
    let s' = left ^ txt ^ right in
    (s', c + String.length txt)

let move_left : x Stab.stab =
  fun (s, c) -> clamp_cursor (s, c - 1)

let move_right : x Stab.stab =
  fun (s, c) -> clamp_cursor (s, c + 1)

let clear : x Stab.stab =
  fun _ -> empty

(* -------------------------------------------------------------------------- *)
(* Affichage                                                                  *)
(* -------------------------------------------------------------------------- *)

let clear_screen () =
  (* ANSI: clear screen + move cursor to top-left *)
  print_string "\027[2J\027[H"

let print_help () =
  print_endline "Commands:";
  print_endline "  :left            move cursor left";
  print_endline "  :right           move cursor right";
  print_endline "  :insert <text>   insert text at cursor";
  print_endline "  :clear           clear the text";
  print_endline "  :quit            quit";
  print_endline ""

let draw (m : (x, string) Machine.t) =
  clear_screen ();
  let view = (Machine.obs m) (Machine.space m) in
  print_endline "Calame — REPL textuel 0.0.1";
  print_help ();  
  print_endline view;
  print_endline "";
  print_string "> ";
  flush stdout

(* -------------------------------------------------------------------------- *)
(* REPL                                                                       *)
(* -------------------------------------------------------------------------- *)

let apply_stab (stab : x Stab.stab) (m : (x, string) Machine.t) =
  (* Interprétation explicite : appliquer la stabilisation,
     puis reconstruire une machine « propre ». *)
  let m' = Machine.with_stab stab m in
  let space' = (Machine.stab m') (Machine.space m') in
  Machine.make
    ~space:space'
    ~obs:(Machine.obs m')
    ~stab:Stab.id

let rec repl (m : (x, string) Machine.t) =
  draw m;
  match read_line () with
  | exception End_of_file ->
      print_endline "";
      ()

  | ":quit" ->
      ()

  | ":left" ->
      repl (apply_stab move_left m)

  | ":right" ->
      repl (apply_stab move_right m)

  | ":clear" ->
      repl (apply_stab clear m)

  | cmd when String.length cmd >= 8
           && String.sub cmd 0 8 = ":insert " ->
      let txt = String.sub cmd 8 (String.length cmd - 8) in
      repl (apply_stab (insert txt) m)

  | txt ->
      (* Par défaut, on insère le texte brut *)
      repl (apply_stab (insert txt) m)

(* -------------------------------------------------------------------------- *)
(* Entrée principale                                                          *)
(* -------------------------------------------------------------------------- *)

let () =
  let m =
    Machine.make
      ~space:empty
      ~obs:render
      ~stab:Stab.id
  in
  repl m
