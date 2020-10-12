defmodule AppUnite.Pharmacy.BudgetHistoryModelTest do
  use AppUnite.DataCase

  alias AppUnite.Pharmacy.BudgetHistoryModel
  alias AppUnite.Pharmacy.BudgetHistory

  @reason "purchase"

  describe "Budget History Model create/1" do
    setup do
      [
        pharmacy: insert(:pharmacy, budget: 12000)
      ]
    end

    test "with valid data", %{pharmacy: pharmacy} do
      assert {:ok, %BudgetHistory{reason: @reason} = history} =
               BudgetHistoryModel.create(pharmacy, 25000, @reason)

      assert Decimal.eq?(history.beforehand, 12000)
      assert Decimal.eq?(history.afterwards, 25000)
    end

    test "without required data", %{pharmacy: pharmacy} do
      assert {:error, _changeset} = BudgetHistoryModel.create(pharmacy, 25000, nil)
      assert {:error, _changeset} = BudgetHistoryModel.create(pharmacy, nil, @reason)
    end

    test "when wrong reason", %{pharmacy: pharmacy} do
      assert {:error, _changeset} = BudgetHistoryModel.create(pharmacy, 25000, "wrong reason")
    end

    test "without parent record" do
      assert_raise FunctionClauseError, fn -> BudgetHistoryModel.create(nil, 25000, @reason) end
    end
  end
end
