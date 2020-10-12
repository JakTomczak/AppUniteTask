defmodule AppUnite.Repo.Migrations.CreateBudgetHistory do
  use Ecto.Migration

  def change do
    create table(:pharmacy_budget_history, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :pharmacy_id, references(:pharmacy, type: :binary_id), null: false

      add :reason, :string, null: false
      add :beforehand, :decimal, null: false
      add :afterwards, :decimal, null: false

      timestamps()
    end

    create index(:pharmacy_budget_history, [:pharmacy_id])
  end
end
