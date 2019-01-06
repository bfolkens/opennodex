FROM elixir:1.7-alpine

RUN apk add --no-cache git && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /workspace
