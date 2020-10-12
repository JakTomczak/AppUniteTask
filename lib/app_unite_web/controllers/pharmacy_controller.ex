defmodule AppUniteWeb.Pharmacy.PharmacyController do
  use AppUniteWeb, :controller

  alias AppUnite.Pharmacy.PharmacyModel

  def index(conn, _params) do
    pharmacies = PharmacyModel.list()

    conn
    |> put_status(:ok)
    |> render("index.json", pharmacies: pharmacies)
  end
end