defmodule PhxFormatter.MixProject do
  use Mix.Project

  def project do
    [
      app: :phx_formatter,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.4.0"},
      {:phoenix, "~> 1.4.0"}
    ]
  end
end
