defmodule AppUnite.Pharmacy.PharmacyModel do
  alias AppUnite.Repo

  alias AppUnite.Pharmacy.Pharmacy

  @initial_budget 25000

  def create(name) do
    params = %{
      name: name,
      budget: @initial_budget
    }

    %Pharmacy{}
    |> Pharmacy.changeset(params)
    |> Repo.create()
  end
end