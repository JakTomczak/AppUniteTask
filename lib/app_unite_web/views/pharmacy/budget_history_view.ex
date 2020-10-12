defmodule AppUniteWeb.Pharmacy.BudgetHistoryView do
  use AppUniteWeb, :view

  def render("budget_history.json", %{history: history}) do
    %{
      id: history.id,
      pharmacy_id: history.pharmacy_id,
      reason: history.reason,
      beforehand: history.beforehand,
      afterwards: history.afterwards,
      inserted_at: history.inserted_at
    }
  end
end
