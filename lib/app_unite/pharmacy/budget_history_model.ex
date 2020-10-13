defmodule AppUnite.Pharmacy.BudgetHistoryModel do
  @moduledoc """
  Module for functions operating only on Budget History.
  """

  alias AppUnite.Repo

  alias AppUnite.Pharmacy.BudgetHistory
  alias AppUnite.Pharmacy.Pharmacy
  alias AppUnite.Pharmacy.PharmacyModel

  @type t :: %BudgetHistory{
    pharmacy: PharmacyModel.t(),
    reason: String.t(),
    beforehand: Decimal.t(),
    afterwards: Decimal.t()
  }

  @doc """
  Creates Bduget History as a child of Pharmacy and with given arguments.
  """
  @spec create(PharmacyModel.t(), Decimal.t(), String.t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create(%Pharmacy{} = pharmacy, new_budget, reason) do
    params = %{
      beforehand: pharmacy.budget,
      afterwards: new_budget,
      reason: reason
    }

    %BudgetHistory{}
    |> BudgetHistory.changeset(pharmacy, params)
    |> Repo.insert()
  end

  @doc """
  Lists all Budget Histories.
  """
  @spec list() :: [t()]
  def list() do
    BudgetHistory
    |> Repo.all()
  end
end
