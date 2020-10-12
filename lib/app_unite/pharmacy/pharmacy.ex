defmodule AppUnite.Pharmacy.Pharmacy do
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
end
