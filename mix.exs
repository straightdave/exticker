defmodule ExTicker.MixProject do
  use Mix.Project

  def project do
    [
      app: :exticker,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      name: "ExTicker",
      source_url: "https://github.com/straightdave/exticker"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  defp description() do
    "Simple Elixir ticker"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
