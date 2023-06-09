
# Trace

[![Build and Test](https://github.com/c-cube/trace/actions/workflows/main.yml/badge.svg)](https://github.com/c-cube/trace/actions/workflows/main.yml)

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
- [x] Tracy (see [ocaml-tracy](https://github.com/imandra-ai/ocaml-tracy), more specifically `tracy-client.trace`)
- [x] Opentelemetry (see [ocaml-opentelemetry](https://github.com/imandra-ai/ocaml-opentelemetry/), in `opentelemetry.trace`)
- [ ] landmarks?
- [ ] Logs (only for messages, obviously)
