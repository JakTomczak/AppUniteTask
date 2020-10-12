defmodule AppUniteWeb.Pharmacy.PharmacyControllerTest do
  use AppUniteWeb.ConnCase

  describe "Pharmacy Controller GET index/2" do
    setup do
      [
        url: "/api/pharmacies"
      ]
    end

    test "returns all fields", context do
      %{id: id, name: name, budget: budget} = insert(:pharmacy)

      conn = get(context.conn, context.url)

      assert %{
        "data" => [pharmacy]
      } = json_response(conn, 200)

      assert %{
        "id" => ^id,
        "name" => ^name
      } = pharmacy

      assert Decimal.eq?(budget, pharmacy["budget"])
    end

    test "sort by name ascending", context do
      insert(:pharmacy, name: "aba")
      insert(:pharmacy, name: "baa")
      insert(:pharmacy, name: "aab")

      conn = get(context.conn, context.url)

      assert %{
        "data" => [
          %{"name" => "aab"},
          %{"name" => "aba"},
          %{"name" => "baa"}
        ]
      } = json_response(conn, 200)
    end
  end
end