
# Trace

This small library provides basic types that can be used to instrument
a library or application, either by hand or via a ppx.

### Features

- [x] spans
- [x] messages
- [ ] counters
- [ ] other metrics?

### Backends

Concrete tracing or observability formats such as:
- [ ] Fuchsia (see [tracing](https://github.com/janestreet/tracing))
- Catapult
  * [x] light bindings here with `trace-tef`
  * [ ] richer bindings with [ocaml-catapult](https://github.com/imandra-ai/catapult),
        with multi-process backends, etc.
- [ ] Tracy (see [ocaml-tracy](https://github.com/imandra-ai/ocaml-tracy))
- [ ] landmarks?
- [ ] Logs (only for messages, obviously)
