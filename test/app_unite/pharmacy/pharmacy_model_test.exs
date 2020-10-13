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

  describe "Pharmacy Model update_budget/2" do
    test "with valid data" do
      pharmacy = insert(:pharmacy)

      assert {:ok, %Pharmacy{budget: budget}} = PharmacyModel.update_budget(pharmacy, 777)

      assert Decimal.eq?(budget, 777)
    end

    test "without required data" do
      pharmacy = insert(:pharmacy)

      assert {:error, _changeset} = PharmacyModel.update_budget(pharmacy, nil)
    end

    test "when argument isn't Pharmacy" do
      assert_raise FunctionClauseError, fn -> PharmacyModel.update_budget(nil, 777) end
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

  describe "Pharmacy Model preload/1" do
    test "preloads associations" do
      pharmacy = insert(:pharmacy)
      insert(:pharmacy_budget_history, pharmacy_id: pharmacy.id)

      pharmacy = PharmacyModel.preload(pharmacy)

      assert [_history] = pharmacy.budget_histories
    end

    test "when argument isn't Pharmacy" do
      assert_raise FunctionClauseError, fn -> PharmacyModel.preload(nil) end
    end
  end

  describe "Pharmacy Model get/1" do
    test "when record exists" do
      %{id: id} = insert(:pharmacy)

      assert {:ok, %Pharmacy{id: ^id}} = PharmacyModel.get(id)
    end

    test "when record doesn't exist" do
      assert {:error, :not_found, "Pharmacy"} = PharmacyModel.get(Ecto.UUID.generate())
    end

    test "when nil given" do
      assert {:error, :get_nil, "Pharmacy"} = PharmacyModel.get(nil)
    end
  end
end
