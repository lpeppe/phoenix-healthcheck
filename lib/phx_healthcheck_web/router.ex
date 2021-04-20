defmodule PhxHealthcheckWeb.Router do
  use PhxHealthcheckWeb, :router

  get "/status", PhxHealthcheckWeb.HealthcheckController, :status
end
