defmodule AppUniteWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import AppUniteWeb.ConnCase

      alias AppUniteWeb.Router.Helpers, as: Routes

      alias AppUnite.Repo
      import Ecto.Query
      import AppUnite.Factory

      # The default endpoint for testing
      @endpoint AppUniteWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AppUnite.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(AppUnite.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
