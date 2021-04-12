defmodule PhxHealthcheckWeb.Router do
  use PhxHealthcheckWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxHealthcheckWeb do
    pipe_through :api
  end
end
