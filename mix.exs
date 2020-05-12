defmodule Jsonnet.MixProject do
  use Mix.Project

  def project do
    [
      app: :jsonnet,
      version: "0.2.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [jsonnet_bindings: []],
      package: package(),
      deps: deps(),
      dialyzer: [
        plt_add_deps: :transitive
      ],
      description: """
      A Jsonnet client for Elixir.
      """
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Michael Simpson"],
      licenses: ["MPL-2.0"],
      links: %{github: "https://github.com/mjs2600/jsonnet"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev]},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.1"},
      {:rustler, "~> 0.21.0"}
    ]
  end
end
