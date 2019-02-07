# OpenNodex

[![Hex version badge](https://img.shields.io/hexpm/v/opennodex.svg)](https://hex.pm/packages/opennodex)
[![Build status badge](https://img.shields.io/circleci/project/github/bfolkens/opennodex/master.svg)](https://circleci.com/gh/bfolkens/opennodex/tree/master)
[![Code coverage badge](https://img.shields.io/codecov/c/github/bfolkens/opennodex/master.svg)](https://codecov.io/gh/bfolkens/opennodex/branch/master)

A (very) simple interface to opennode.co - more to come if this gets wings.

## Installation

The package can be installed by adding `opennodex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:opennodex, "~> 0.4.0"}
  ]
end
```

API Documentation is also available at [https://hexdocs.pm/opennodex](https://hexdocs.pm/opennodex).

## Configuration

You can set a default api key and alternative request module via the configuration:

```elixir
config :opennodex,
  request: OpenNodex.Request,
  api_key: "api_key"
```

## Usage

Create a $99 charge, with callback and success URLs:

```elixir
OpenNodex.Client.new("[your api_key here]")
|> OpenNodex.create_charge(99, "USD", "https://example.com/callback", "https://example.com/success")
```
Will return an `{:ok, %Charge{id: ...}}` upon success or `{:error, ...}` on failure.

## Testing

A MockRequest module has been supplied, and is interchangeable with the default Request module.  By configuring the request to use the MockRequest module instead, you can test your app without side-effects or external service dependencies.  Also, you can replace the stock request library for your own.

As an example, you can place the following in your config.exs (or `config/test.exs`) in order to override the request module when tests are run.

```elixir
config :opennodex,
  request: OpenNodex.MockRequest
```

## TODO

* Phoenix integration for the callback events.

