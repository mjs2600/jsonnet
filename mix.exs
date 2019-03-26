defmodule Jsonnet.MixProject do
  use Mix.Project

  def project do
    [
      app: :jsonnet,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [jsonnet_bindings: []],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0"},
      {:dialyxir, "~> 1.0.0-rc.4"},
      {:jason, "~> 1.1"},
      {:rustler, "~> 0.20.0"}
    ]
  end
end
