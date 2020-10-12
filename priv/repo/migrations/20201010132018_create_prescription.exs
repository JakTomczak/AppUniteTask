defmodule AppUnite.Repo.Migrations.CreatePrescription do
  use Ecto.Migration

  def change do
    create table(:pharmacy, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string, null: false
      add :budget, :decimal,  null: false, default: 0

      timestamps()
    end

    create unique_index(:pharmacy, [:name], name: :name_of_the_pharmacy)
  end
end
