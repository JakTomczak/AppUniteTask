defmodule AppUnite.Pharmacy.PharmacyModel do
  @moduledoc """
  Module for functions operating only on Pharmacy.
  """

  alias AppUnite.Repo
  require Ecto.Query
  alias Ecto.Query

  alias AppUnite.Pharmacy.Pharmacy

  @type t :: %Pharmacy{
    name: String.t(),
    budget: Decimal.t(),
    budget_histories: [AppUnite.Pharmacy.BudgetHistoryModel.t()]
  }

  @initial_budget 100_000

  @preloads [:budget_histories]

  @doc """
  Creates Pharmacy with given name.
  """
  @spec create(String.t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create(name) do
    params = %{
      name: name,
      budget: @initial_budget
    }

    %Pharmacy{}
    |> Pharmacy.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates Pharmacy's :budget with given value.
  """
  @spec update_budget(t(), Decimal.t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def update_budget(%Pharmacy{} = pharmacy, new_budget) do
    params = %{
      budget: new_budget
    }

    pharmacy
    |> Pharmacy.update_budget_changeset(params)
    |> Repo.update()
  end

  @doc """
  Lists all Pharmacies.
  Sorts by name ascending.
  Listed Pharmacies have preloaded associations.
  """
  @spec list() :: [t()]
  def list() do
    Pharmacy
    |> Query.preload(^@preloads)
    |> Query.order_by(asc: :name)
    |> Repo.all()
  end

  @doc """
  Preload's Pharmacy's associations.
  """
  @spec preload(t()) :: t()
  def preload(%Pharmacy{} = pharmacy) do
    pharmacy
    |> Repo.preload(@preloads)
  end

  @doc """
  Returns a Pharmacy from an ID.
  """
  @spec get(binary()) :: {:ok, t()} | {:error, atom(), String.t()}
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
