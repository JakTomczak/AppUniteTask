defmodule AppUnite.Pharmacy.PharmacyModelTest do
  use AppUnite.DataCase

  alias AppUnite.Pharmacy.PharmacyModel
  alias AppUnite.Pharmacy.Pharmacy

  @name "Pharmacy name"

  describe "Pharmacy Model create/1" do
    test "with valid data" do
      assert {:ok, %Pharmacy{name: @name, budget: budget}} = PharmacyModel.create(@name)

      assert Decimal.eq?(budget, 100_000)
    end

    test "without required data" do
      assert {:error, _changeset} = PharmacyModel.create(nil)
    end

    test "with unique constraint violation" do
      PharmacyModel.create(@name)

      assert {:error, _changeset} = PharmacyModel.create(@name)
    end
  end

  describe "Pharmacy Model list/0" do
    test "preloads children" do
      insert(:pharmacy)

      assert [%Pharmacy{budget_histories: []}] = PharmacyModel.list()
    end

    test "sorts the results by name" do
      insert(:pharmacy, name: "D")
      insert(:pharmacy, name: "A")
      insert(:pharmacy, name: "C")
      insert(:pharmacy, name: "B")

      assert [
        %Pharmacy{name: "A"},
        %Pharmacy{name: "B"},
        %Pharmacy{name: "C"},
        %Pharmacy{name: "D"}
      ] = PharmacyModel.list()
    end

    test "when empty results" do
      assert [] = PharmacyModel.list()
    end
  end
end
