defmodule PhxHealthcheck.Healthcheck.Services.Database do
  alias PhxHealthcheck.{Healthcheck, Repo}
  import Ecto.Adapters.SQL

  @behaviour Healthcheck

  def check_status() do
    try do
      query(Repo, "SELECT 1")
    rescue
      e in RuntimeError -> e
    end
    |> case do
      {:ok, _} -> "healthy"
      _ -> "unhealthy"
    end
  end
end
