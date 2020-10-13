defmodule AppUniteWeb.Pharmacy.PharmacyController do
  use AppUniteWeb, :controller

  alias AppUnite.Pharmacy.PharmacyModel
  alias AppUnite.Pharmacy.PharmacyService

  def index(conn, _params) do
    pharmacies = PharmacyModel.list()

    conn
    |> put_status(:ok)
    |> render("index.json", pharmacies: pharmacies)
  end

  def update(conn, %{"id" => pharmacy_id, "data" => params}) do
    with {:ok, pharmacy} <- PharmacyModel.get(pharmacy_id),
         {:ok, pharmacy} <- PharmacyService.update_budget(pharmacy, params) do
      conn
      |> put_status(:accepted)
      |> render("show.json", pharmacy: pharmacy)
    end
  end

  def update(conn, %{"id" => _pharmacy_id}) do
    conn
    |> send_resp(:bad_request, "Field 'data' of type JSON is required.")
  end
end
