defmodule PhxHealthcheck.Healthcheck.Worker do
  use GenServer

  @spec start_link(list()) :: GenServer.on_start()
  def start_link([service | _] = args) do
    GenServer.start_link(__MODULE__, args, name: service)
  end

  @impl true
  def init([service, refresh_interval]) do
    state = %{
      service: service,
      refresh_interval: refresh_interval
    }

    {:ok, state, {:continue, :init_service_status}}
  end

  @impl true
  def handle_continue(:init_service_status, state), do: execute_refresh_status(state)

  @impl true
  def handle_info({:refresh_status}, state), do: execute_refresh_status(state)

  @impl true
  def handle_call({:get_status}, _from, %{service_status: service_status} = state) do
    {:reply, service_status, state}
  end

  defp execute_refresh_status(%{service: service, refresh_interval: refresh_interval} = state) do
    new_service_status = apply(service, :check_status, [])
    new_state = Map.put(state, :service_status, new_service_status)

    Process.send_after(service, {:refresh_status}, refresh_interval)

    {:noreply, new_state}
  end
end
