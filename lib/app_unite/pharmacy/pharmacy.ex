defmodule AppUnite.Pharmacy.Pharmacy do
  @moduledoc """
  Pharmacy is an instance buying drugs from vendors and disbursing them to doctors.
  Pharmacy has a limited daily budget it must strive to uphold.
  No feature should be blocked when budget is negative, it's just an info for admins.
  """

  use AppUnite.Schema

  schema "pharmacy" do
    field :name, :string
    field :budget, :decimal

    has_many :budget_histories, AppUnite.Pharmacy.BudgetHistory

    timestamps()
  end

  @schema_fields [:name, :budget]

  def changeset(schema, params) do
    schema
    |> cast(params, @schema_fields)
    |> validate_required(@schema_fields)
    |> unique_constraint(:name, name: :name_of_the_pharmacy)
  end

  def update_budget_changeset(schema, params) do
    schema
    |> cast(params, [:budget])
    |> validate_required([:budget])
  end
end
