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

  describe "Pharmacy Controller PUT update/2" do
    setup do
      %{id: id} = insert(:pharmacy)

      [
        url: "/api/pharmacies/#{id}",
        params: %{
          "new_budget" => -1000,
          "reason" => "purchase"
        }
      ]
    end

    test "updates budget and stores history", context do
      params = %{"data" => context.params}

      conn = put(context.conn, context.url, params)

      assert %{
               "data" => %{
                 "budget" => "-1000",
                 "budget_histories" => [
                   %{
                     "reason" => "purchase",
                     "afterwards" => "-1000"
                   }
                 ]
               }
             } = json_response(conn, 202)
    end

    test "when wrong pharmacy_id given", context do
      url = "/api/pharmacies/#{Ecto.UUID.generate()}"

      params = %{"data" => context.params}

      conn = put(context.conn, url, params)

      assert response(conn, 404) =~ "Pharmacy"
    end

    test "when no data given", context do
      params = %{}

      conn = put(context.conn, context.url, params)

      assert response(conn, 400) =~ "required"
    end

    test "when required field is missing", context do
      params = %{
        "data" => Map.delete(context.params, "new_budget")
      }

      conn = put(context.conn, context.url, params)

      assert %{
               "message" => "Error during operating on Pharmacy Budget History.",
               "errors" => [
                 %{
                   "field" => "afterwards",
                   "message" => "can't be blank"
                 }
               ]
             } = json_response(conn, 422)
    end
  end
end
