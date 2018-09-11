defmodule Mg.Docker.MixProject do
  use Mix.Project

  def project do
    [
      app: :mingus_docker,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      {:mod, {Mg.Docker, []}},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:cowboy, "~> 2.4"},
      {:plug, "~> 1.6"},
      {:libsniffle, "~> 0.3", git: "https://gitlab.com/jean.parpaillon/libsniffle.git"},
      {:fifo_dt, git: "https://gitlab.com/Project-FiFo/FiFo/fifo_dt.git", override: true}
    ]
  end
end
