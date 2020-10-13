defmodule AppUnite.Pharmacy.PharmacyModel do
  alias AppUnite.Repo
  require Ecto.Query
  alias Ecto.Query

  alias AppUnite.Pharmacy.Pharmacy

  @initial_budget 100_000

  @preloads [:budget_histories]

  def create(name) do
    params = %{
      name: name,
      budget: @initial_budget
    }

    %Pharmacy{}
    |> Pharmacy.changeset(params)
    |> Repo.insert()
  end

  def update_budget(%Pharmacy{} = pharmacy, new_budget) do
    params = %{
      budget: new_budget
    }

    pharmacy
    |> Pharmacy.update_budget_changeset(params)
    |> Repo.update()
  end

  def list() do
    Pharmacy
    |> Query.preload(^@preloads)
    |> Query.order_by(asc: :name)
    |> Repo.all()
  end

  def preload(%Pharmacy{} = pharmacy) do
    pharmacy
    |> Repo.preload(@preloads)
  end

  def get(nil), do: {:error, :get_nil, "Pharmacy"}

  def get(id) do
    Pharmacy
    |> Repo.get(id)
    |> case do
      nil -> {:error, :not_found, "Pharmacy"}
      pharmacy -> {:ok, pharmacy}
    end
  end
end
