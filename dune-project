(lang dune 3.10)

(name ocaml_backend)

(generate_opam_files true)

(source
 (github kwf37/ocaml-backend))

(authors "Kenneth Fang")

(maintainers "Kenneth Fang")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name ocaml_backend)
 (synopsis "Backend in OCaml")
 (description "Fun little side project")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
