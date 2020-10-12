defmodule AppUnite.Pharmacy.BudgetHistory do
  use AppUnite.Schema

  schema "pharmacy_budget_history" do
    belongs_to :pharmacy, AppUnite.Pharmacy.Pharmacy

    field :reason, :string
    field :beforehand, :decimal
    field :afterwards, :decimal

    timestamps()
  end

  @enum_reason ["purchase", "refund", "scheduled_increase", "other"]

  @schema_fields [:reason, :beforehand, :afterwards]

  @required_fields [:pharmacy | @schema_fields]

  def changeset(schema, pharmacy, params) do
    schema
    |> cast(params, @schema_fields)
    |> put_assoc(:pharmacy, pharmacy)
    |> validate_required(@required_fields)
    |> validate_inclusion(:reason, @enum_reason)
  end
end
