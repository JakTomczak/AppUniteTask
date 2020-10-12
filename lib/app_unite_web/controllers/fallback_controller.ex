defmodule AppUniteWeb.FallbackController do
  use Phoenix.Controller

  alias AppUniteWeb.ErrorView

  def call(conn, {:error, :not_found, schema}) do
    conn
    |> send_resp(:not_found, "No entry of type: #{schema}")
  end

  def call(conn, {:error, :get_nil, schema}) do
    conn
    |> send_resp(:bad_request, "Cannot get #{schema}, because null given.")
  end

  def call(conn, {:error, schema, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render(:error, changeset: changeset, type: schema)
  end
end