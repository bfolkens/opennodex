defmodule OpenNodex.MixProject do
  use Mix.Project

  @github_url "https://github.com/bfolkens/opennodex"

  def project do
    [
      app: :opennodex,
      name: "OpenNodex",
      description: "Opennode.co Elixir Client",
      version: "0.3.6",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      package: [
        maintainers: ["Brad Folkens"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => @github_url,
        },
        files: ~w(mix.exs lib LICENSE README.md)
      ],
      source_url: @github_url,
      homepage_url: @github_url,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpotion]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:httpotion, "~> 3.1.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.10", only: :test},
      {:junit_formatter, "~> 2.1", only: :test} # formatting for CircleCI
    ]
  end
end
