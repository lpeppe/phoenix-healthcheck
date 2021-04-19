defmodule PhxHealthcheck.Healthcheck do
  @callback check_status() :: String.t()
end
