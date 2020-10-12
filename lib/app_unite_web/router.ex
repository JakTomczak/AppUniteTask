defmodule AppUniteWeb.Router do
  use AppUniteWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppUniteWeb do
    pipe_through :api

    resources "/pharmacies", Pharmacy.PharmacyController, only: [:index, :update]
  end
end
