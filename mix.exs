defmodule GitDiff.Mixfile do
  use Mix.Project

  def project do
    [
      app: :git_diff,
      deps: deps(),
      elixir: "~> 1.5",
      name: "GitDiff",
      package: package(),
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      source_url: "https://github.com/mononym/git_diff",
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.1.0",
    ]
  end

  defp package do
    [
      description: "A simple, naive parser for output from 'git diff'",
      files: ["lib", "config", "mix.exs", "README.md", "LICENSE.txt"],
      maintainers: ["Chris Hicks"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mononym/git_diff"}
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
      {:excoveralls, "~> 0.7", only: :test},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
