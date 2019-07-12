defmodule FixId.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fix_id,
      version: "0.0.1",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {FixId, []},
      applications: [:logger, :parallel_tree_walk]
    ]
  end

  def escript do
    [
      main_module: FixId,
      emu_args: "+A32"
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:parallel_tree_walk, git: "https://github.com/thomasbuttler/ParallelTreeWalk.git"},
      {:distillery, "~> 2.0"}
    ]
  end
end
