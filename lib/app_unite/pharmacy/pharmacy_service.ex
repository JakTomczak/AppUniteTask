defmodule AppUnite.Pharmacy.PharmacyService do
  @moduledoc """
  Modlue for functions oparating on many related-to-pharmacy schemas.
  """

  alias AppUnite.Repo
  alias Ecto.Multi

  alias AppUnite.Pharmacy.PharmacyModel
  alias AppUnite.Pharmacy.BudgetHistoryModel

  @spec update_budget(PharmacyModel.t(), map()) :: {:ok, PharmacyModel.t()} | {:error, String.t(), Ecto.Changeset.t()}
  def update_budget(pharmacy, params) do
    Multi.new()
    |> Multi.run(:history, fn _repo, _changes ->
      BudgetHistoryModel.create(
        pharmacy,
        params["new_budget"],
        params["reason"]
      )
    end)
    |> Multi.run(:pharmacy, fn _repo, %{history: history} ->
      PharmacyModel.update_budget(pharmacy, history.afterwards)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{pharmacy: pharmacy}} ->
        {:ok, pharmacy}

      {:error, :history, %Ecto.Changeset{} = changeset, _} ->
        {:error, "Pharmacy Budget History", changeset}

      {:error, :pharmacy, %Ecto.Changeset{} = changeset, _} ->
        {:error, "Pharmacy", changeset}
    end
  end
end
