defmodule OpenNodex.MixProject do
  use Mix.Project

  def project do
    [
      app: :opennodex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpotion],
      mod: {OpenNodex.Application, []}
    ]
  end

  defp deps do
    [
      {:decimal, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:httpotion, "~> 3.1.0"}
    ]
  end
end
