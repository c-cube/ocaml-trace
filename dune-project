(lang dune 2.9)

(name trace)

(generate_opam_files true)

(version 0.9.1)

(source
 (github c-cube/ocaml-trace))

(authors "Simon Cruanes")

(maintainers "Simon Cruanes")

(license MIT)

;(documentation https://url/to/documentation)

(package
 (name trace)
 (synopsis
  "A stub for tracing/observability, agnostic in how data is collected")
 (depends
  (ocaml
   (>= 4.08))
  dune)
 (depopts
  hmap
  (mtime
   (>= 2.0)))
 (tags
  (trace tracing observability profiling)))

(package
 (name ppx_trace)
 (synopsis "A ppx-based preprocessor for trace")
 (depends
  (ocaml
   (>= 4.12)) ; we use __FUNCTION__
  (ppxlib
   (and (>= 0.28) (< 0.36)))
  (trace
   (= :version))
  (trace-tef
   (and
    (= :version)
    :with-test))
  dune)
 (depopts
   (mtime (>= 2.0)))
 (tags
  (trace ppx)))

(package
 (name trace-tef)
 (synopsis
  "A simple backend for trace, emitting Catapult/TEF JSON into a file")
 (depends
  (ocaml
   (>= 4.08))
  (trace
   (= :version))
  (mtime
   (>= 2.0))
  base-unix
  dune)
 (tags
  (trace tracing catapult TEF chrome-format)))

(package
 (name trace-fuchsia)
 (synopsis
  "A high-performance backend for trace, emitting a Fuchsia trace into a file")
 (depends
  (ocaml
   (>= 4.08))
  (trace
   (= :version))
  (mtime
   (>= 2.0))
  (thread-local-storage
   (>= 0.2))
  base-bigarray
  base-unix
  dune)
 (tags
  (trace tracing fuchsia)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
