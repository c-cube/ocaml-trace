(lang dune 2.9)

(name trace)
(generate_opam_files true)

(source
 (github c-cube/trace))
(authors "Simon Cruanes")
(maintainers "Simon Cruanes")
(license MIT)

;(documentation https://url/to/documentation)

(package
 (name trace)
 (synopsis "A stub for tracing/observability")
 (depends
   (ocaml (>= 4.05))
   dune)
 (tags
  (trace tracing observability profiling)))

(package
 (name trace-tef)
 (synopsis "A simple backend for trace")
 (depends
   (ocaml (>= 4.05))
   (trace (= :version))
   mtime
   base-unix
   dune)
 (tags
  (trace tracing catapult)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
