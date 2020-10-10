defmodule AppUnite.Pharmacy.PharmacyModel do
  alias AppUnite.Repo

  alias AppUnite.Pharmacy.Pharmacy

  @initial_budget 75000

  def create(name) do
    params = %{
      name: name,
      budget: @initial_budget
    }

    %Pharmacy{}
    |> Pharmacy.changeset(params)
    |> Repo.insert()
  end
end