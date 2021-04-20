defmodule PhxHealthcheck.Healthcheck do
  @callback check_status() :: String.t()

  @spec get_service_status(atom()) :: String.t()
  def get_service_status(service) do
    GenServer.call(service, {:get_status})
  end
end
