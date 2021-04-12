defmodule PhxHealthcheck.Repo do
  use Ecto.Repo,
    otp_app: :phx_healthcheck,
    adapter: Ecto.Adapters.Postgres
end
