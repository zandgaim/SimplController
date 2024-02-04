defmodule Www.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WwwWeb.Telemetry,
      Www.Repo,
      {DNSCluster, query: Application.get_env(:www, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Www.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Www.Finch},
      # Start a worker by calling: Www.Worker.start_link(arg)
      # {Www.Worker, arg},
      # Start to serve requests, typically the last entry
      WwwWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Www.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WwwWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
