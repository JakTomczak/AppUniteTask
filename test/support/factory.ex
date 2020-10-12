defmodule AppUnite.Factory do
  use ExMachina.Ecto, repo: AppUnite.Repo

  def pharmacy_factory do
    %AppUnite.Pharmacy.Pharmacy{
      name: sequence(:pharmacy_name, &"factory built pharmacy name #{&1}"),
      budget: 10000
    }
  end
end