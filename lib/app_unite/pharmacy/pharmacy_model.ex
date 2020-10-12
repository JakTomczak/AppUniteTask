defmodule AppUnite.Pharmacy.PharmacyModel do
  alias AppUnite.Repo
  import Ecto.Query

  alias AppUnite.Pharmacy.Pharmacy

  @initial_budget 100_000

  def preloads, do: [:budget_histories]

  def create(name) do
    params = %{
      name: name,
      budget: @initial_budget
    }

    %Pharmacy{}
    |> Pharmacy.changeset(params)
    |> Repo.insert()
  end

  def list() do
    Pharmacy
    |> preload(^preloads())
    |> order_by(asc: :name)
    |> Repo.all()
  end
end
