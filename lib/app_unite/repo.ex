defmodule AppUnite.Repo do
  use Ecto.Repo,
    otp_app: :app_unite,
    adapter: Ecto.Adapters.Postgres
end
