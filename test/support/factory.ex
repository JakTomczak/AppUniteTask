defmodule AppUnite.Factory do
  use ExMachina.Ecto, repo: AppUnite.Repo

  def pharmacy_factory do
    %AppUnite.Pharmacy.Pharmacy{
      name: sequence(:pharmacy_name, &"factory built pharmacy name #{&1}"),
      budget: 10000
    }
  end

  def pharmacy_budget_history_factory do
    %AppUnite.Pharmacy.BudgetHistory{
      pharmacy_id: Ecto.UUID.generate(),
      reason: "purchase",
      beforehand: 10000,
      afterwards: 9500
    }
  end
end
