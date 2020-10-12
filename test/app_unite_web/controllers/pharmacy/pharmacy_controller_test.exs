defmodule AppUniteWeb.Pharmacy.PharmacyControllerTest do
  use AppUniteWeb.ConnCase

  describe "Pharmacy Controller GET index/2" do
    setup do
      [
        url: "/api/pharmacies"
      ]
    end

    test "returns all fields", context do
      budget = 300

      %{id: id, name: name} = insert(:pharmacy, budget: budget)

      insert(:pharmacy_budget_history, pharmacy_id: id, beforehand: 2 * budget, afterwards: budget)

      conn = get(context.conn, context.url)

      assert %{
               "data" => [pharmacy]
             } = json_response(conn, 200)

      assert Decimal.eq?(budget, pharmacy["budget"])

      assert %{
               "id" => ^id,
               "name" => ^name,
               "budget_histories" => [
                 %{
                   "id" => _id,
                   "pharmacy_id" => ^id,
                   "reason" => "purchase",
                   "beforehand" => "600",
                   "afterwards" => "300"
                 }
               ]
             } = pharmacy
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
