defmodule PhxHealthcheckWeb.HealthcheckController do
  use PhxHealthcheckWeb, :controller

  alias PhxHealthcheck.Healthcheck

  def status(conn, _params) do
    monitorable_services =
      :phx_healthcheck
      |> Application.get_env(:healthcheck, services: [])
      |> Keyword.fetch!(:services)

    services_status =
      monitorable_services
      |> Enum.map(&fetch_service_status!/1)
      |> Enum.into(%{})

    json(conn, services_status)
  end

  defp fetch_service_status!({service, opts}) do
    service_name = Keyword.fetch!(opts, :name)
    service_status = Healthcheck.get_service_status(service)

    {service_name, service_status}
  end
end
