defmodule AppUnite.Pharmacy.BudgetHistoryModel do
  alias AppUnite.Repo

  alias AppUnite.Pharmacy.BudgetHistory
  alias AppUnite.Pharmacy.Pharmacy

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
end
