(lang dune 3.20)

(name calame)

(generate_opam_files true)

(package
 (name calame)
 (allow_empty)
 (synopsis "Small parametric machine for slow experimentation")
 (description
"
Calame, Roseau taillé dont les Anciens se servaient pour écrire.
Calame, un état, une transition et une observation. 
Calame, pensée pour l'expérimentation sur les systèmes réflexifs.
")
 (depends
  (ocaml (>= 5.0))))
