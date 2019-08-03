defmodule Zx.BusinessTest do
  use Zx.DataCase

  alias Zx.Business

  describe "partners" do
    alias Zx.Business.Partner

    @valid_attrs %{
      trading_name: "some trading_name",
      owner_name: "some owner_name",
      document: "some document",
      address: %{"lat" => 10.2, "lng" => 20.5},
      coverage_area: [[[[23, 45], [12.1, 23], [45, 87], [23.6, 23], [23, 45]]]]
    }
    @update_attrs %{
      trading_name: "some updated trading_name",
      owner_name: "some updated owner_name",
      document: "some updated document",
      address: %{"lat" => 16.8, "lng" => 28},
      coverage_area: [[[[12.1, 23], [11, 11], [34, 23], [54, 76], [12.1, 23]]]]
    }
    @invalid_attrs %{
      trading_name: nil,
      owner_name: nil,
      document: nil,
      address: {10.2, 20.5},
      coverage_area: [[{"asd", "dhj"}]]
    }

    @center_square_partner %{
      trading_name: "Center Square Partner",
      owner_name: "Test Suite",
      document: "35.685.536/0001-72",
      address: %{"lat" => 0, "lng" => 0},
      coverage_area: [[[[10, 10], [10, -10], [-10, -10], [-10, 10], [10, 10]]]]
    }

    @top_right_square_partner %{
      trading_name: "Top Right Square Partner",
      owner_name: "Test Suite",
      document: "34.413.275/0001-79",
      address: %{"lat" => 10, "lng" => 10},
      coverage_area: [[[[20, 20], [20, 0], [0, 0], [0, 20], [20, 20]]]]
    }

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_partner()

      partner
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Business.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Business.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Business.create_partner(@valid_attrs)
      assert partner.trading_name == "some trading_name"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Business.update_partner(partner, @update_attrs)
      assert partner.trading_name == "some updated trading_name"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_partner(partner, @invalid_attrs)
      assert partner == Business.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Business.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Business.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Business.change_partner(partner)
    end


    # Relevant tests for the job application

    test "list_covering_partners/2" do
      assert {:ok, %Partner{} = partner1} = Business.create_partner(@center_square_partner)
      assert {:ok, %Partner{} = partner2} = Business.create_partner(@top_right_square_partner)

      assert [p1, p2] = Business.list_covering_partners(2, 2)

      assert [p1.id, p2.id] == [partner1.id, partner2.id]

      assert partner1.id == hd(Business.list_covering_partners(2, -2)).id

      assert partner2.id == hd(Business.list_covering_partners(12, 12)).id

      assert [] == Business.list_covering_partners(-12, -12)
      assert [] == Business.list_covering_partners(12, -5)
    end

    test "get_nearest_partner/3" do
      assert {:ok, %Partner{} = partner1} = Business.create_partner(@center_square_partner)
      assert {:ok, %Partner{} = partner2} = Business.create_partner(@top_right_square_partner)

      assert partner1.id == Business.get_nearest_partner(3, 2).id
      assert partner2.id == Business.get_nearest_partner(35, 42).id

      assert nil == Business.get_nearest_partner(35, 42, true)

    end

  end
end
