defmodule Ngepa.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ngepa.Repo,
      # Start the Telemetry supervisor
      NgepaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ngepa.PubSub},
      # Start the Endpoint (http/https)
      NgepaWeb.Endpoint
      # Start a worker by calling: Ngepa.Worker.start_link(arg)
      # {Ngepa.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ngepa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NgepaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
