(lang dune 2.9)

(name trace)
(generate_opam_files true)
(version 0.3)

(source
 (github c-cube/ocaml-trace))
(authors "Simon Cruanes")
(maintainers "Simon Cruanes")
(license MIT)

;(documentation https://url/to/documentation)

(package
 (name trace)
 (synopsis "A stub for tracing/observability, agnostic in how data is collected")
 (depends
   (ocaml (>= 4.08))
   dune)
 (tags
  (trace tracing observability profiling)))

(package
 (name trace-tef)
 (synopsis "A simple backend for trace, emitting Catapult JSON into a file")
 (depends
   (ocaml (>= 4.08))
   (trace (= :version))
   (mtime (>= 2.0))
   base-unix
   dune)
 (tags
  (trace tracing catapult)))

(package
  (name trace-lwt)
  (synopsis "Helpers to use Trace from Lwt")
  (depends
    (trace (= :version))
    lwt)
  (tags (trace lwt asynchronous)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
