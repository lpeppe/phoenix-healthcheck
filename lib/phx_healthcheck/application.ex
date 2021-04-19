defmodule PhxHealthcheck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhxHealthcheck.Repo,
      # Start the Telemetry supervisor
      PhxHealthcheckWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxHealthcheck.PubSub},
      PhxHealthcheck.Healthcheck.Supervisor,
      # Start the Endpoint (http/https)
      PhxHealthcheckWeb.Endpoint
      # Start a worker by calling: PhxHealthcheck.Worker.start_link(arg)
      # {PhxHealthcheck.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxHealthcheck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhxHealthcheckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
