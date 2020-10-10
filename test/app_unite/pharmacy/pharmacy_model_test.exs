defmodule AppUnite.Pharmacy.PharmacyModelTest do
  use AppUnite.DataCase

  alias AppUnite.Pharmacy.PharmacyModel
  alias AppUnite.Pharmacy.Pharmacy

  @name "Pharmacy name"

  describe "Pharmacy Model create/1" do
    test "with valid data" do
      assert {:ok, %Pharmacy{name: @name, budget: budget}} = PharmacyModel.create(@name)

      assert Decimal.eq?(budget, 75000)
    end

    test "without required data" do
      assert {:error, _changeset} = PharmacyModel.create(nil)
    end

    test "with unique constraint violation" do
      PharmacyModel.create(@name)
      
      assert {:error, _changeset} = PharmacyModel.create(@name)
    end
  end
end