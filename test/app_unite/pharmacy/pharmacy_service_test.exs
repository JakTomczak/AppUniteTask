defmodule AppUnite.Pharmacy.PharmacyServiceTest do
  use AppUnite.DataCase

  alias AppUnite.Pharmacy.PharmacyService
  alias AppUnite.Pharmacy.BudgetHistoryModel

  @update_budget_params %{
    "new_budget" => 123_456,
    "reason" => "refund"
  }

  describe "Pharmacy Service update_budget/2" do
    test "creates Budget History and updates Pharmacy" do
      pharmacy = insert(:pharmacy, budget: 100_000)

      assert {:ok, %{id: pharmacy_id} = pharmacy} =
               PharmacyService.update_budget(pharmacy, @update_budget_params)

      assert Decimal.eq?(pharmacy.budget, 123_456)

      assert [
               %{
                 pharmacy_id: ^pharmacy_id,
                 reason: "refund",
                 beforehand: beforehand,
                 afterwards: afterwards
               }
             ] = BudgetHistoryModel.list()

      assert Decimal.eq?(beforehand, 100_000)
      assert Decimal.eq?(afterwards, 123_456)
    end

    test "when Pharmacy is nil" do
      assert_raise FunctionClauseError, fn ->
        PharmacyService.update_budget(nil, @update_budget_params)
      end
    end

    test "when params is nil" do
      pharmacy = insert(:pharmacy)

      assert {:error, "Pharmacy Budget History", _changeset} =
               PharmacyService.update_budget(pharmacy, nil)
    end

    test "when a parameter is not given" do
      pharmacy = insert(:pharmacy)

      params =
        @update_budget_params
        |> Map.delete("reason")

      assert {:error, "Pharmacy Budget History", _changeset} =
               PharmacyService.update_budget(pharmacy, params)
    end
  end
end
