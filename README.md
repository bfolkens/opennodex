# OpenNodex

[![Hex version badge](https://img.shields.io/hexpm/v/opennodex.svg)](https://hex.pm/packages/opennodex)
[![Build status badge](https://img.shields.io/circleci/project/github/bfolkens/opennodex/master.svg)](https://circleci.com/gh/bfolkens/opennodex/tree/master)
[![Code coverage badge](https://img.shields.io/codecov/c/github/bfolkens/opennodex/master.svg)](https://codecov.io/gh/bfolkens/opennodex/branch/master)

A (very) simple interface to opennode.co - more to come if this gets wings.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `opennodex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:opennodex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/opennodex](https://hexdocs.pm/opennodex).

## Configuration

In your config.exs, place a line that sets the `api_key` for `:opennodex`:

```elixir
config :opennodex, api_key: "[your api_key here]"
```
