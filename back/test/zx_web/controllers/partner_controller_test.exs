defmodule ZxWeb.PartnerControllerTest do
  use ZxWeb.ConnCase

  alias Zx.Business
  alias Zx.Business.Partner

  @create_attrs %{
    address: %{"lat" => 10.2, "lng" => 20.5},
    coverage_area: [[[23, 45], [12.1, 23], [45.4, 87], [23.6, 23], [23, 45]]],
    document: "some document",
    owner_name: "some owner_name",
    trading_name: "some trading_name"
  }
  @update_attrs %{
    address: %{"lat" => 16.8, "lng" => 28},
    coverage_area: [[[12.1, 23], [-11, 11], [34, 23], [54.2, 76], [12.1, 23]]],
    document: "some updated document",
    owner_name: "some updated owner_name",
    trading_name: "some updated trading_name"
  }
  @invalid_attrs %{address: nil, coverage_area: nil, document: nil, owner_name: nil, trading_name: nil}

  def fixture(:partner) do
    {:ok, partner} = Business.create_partner(@create_attrs)
    partner
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all partners", %{conn: conn} do
      conn = get(conn, Routes.partner_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create partner" do
    test "renders partner when data is valid", %{conn: conn} do
      conn = post(conn, Routes.partner_path(conn, :create), partner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.partner_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => %{
                  "type" => "Point",
                  "coordinates" => [10.2, 20.5]
               },
               "coverageArea" => %{
                  "type" => "MultiPolygon",
                  "coordinates" => [[[23.0, 45.0], [12.1, 23.0], [45.4, 87.0], [23.6, 23.0], [23.0, 45.0]]]
               },
               "document" => "some document",
               "ownerName" => "some owner_name",
               "tradingName" => "some trading_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.partner_path(conn, :create), partner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update partner" do
    setup [:create_partner]

    test "renders partner when data is valid", %{conn: conn, partner: %Partner{id: id} = partner} do
      conn = put(conn, Routes.partner_path(conn, :update, partner), partner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.partner_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => %{
                  "type" => "Point",
                  "coordinates" => [16.8, 28.0]
                },
               "coverageArea" => %{
                  "type" => "MultiPolygon",
                  "coordinates" => [[[12.1, 23.0], [-11.0, 11.0], [34.0, 23.0], [54.2, 76.0], [12.1, 23.0]]]
               },
               "document" => "some updated document",
               "ownerName" => "some updated owner_name",
               "tradingName" => "some updated trading_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, partner: partner} do
      conn = put(conn, Routes.partner_path(conn, :update, partner), partner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete partner" do
    setup [:create_partner]

    test "deletes chosen partner", %{conn: conn, partner: partner} do
      conn = delete(conn, Routes.partner_path(conn, :delete, partner))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.partner_path(conn, :show, partner))
      end
    end
  end

  defp create_partner(_) do
    partner = fixture(:partner)
    {:ok, partner: partner}
  end
end
