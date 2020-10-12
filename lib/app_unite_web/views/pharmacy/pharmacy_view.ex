defmodule AppUniteWeb.Pharmacy.PharmacyView do
  use AppUniteWeb, :view

  alias AppUniteWeb.Pharmacy.BudgetHistoryView

  def render("index.json", %{pharmacies: pharmacies}) do
    %{
      data: render_many(pharmacies, __MODULE__, "pharmacy.json", as: :pharmacy)
    }
  end

  def render("pharmacy.json", %{pharmacy: pharmacy}) do
    %{
      id: pharmacy.id,
      name: pharmacy.name,
      budget: pharmacy.budget,
      budget_histories:
        render_many(pharmacy.budget_histories, BudgetHistoryView, "budget_history.json",
          as: :history
        )
    }
  end
end
