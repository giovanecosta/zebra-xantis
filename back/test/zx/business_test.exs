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
      coverage_area: [[[23, 45], [12.1, 23], [45,87], [23.6,23], [23, 45]]]
    }
    @update_attrs %{
      trading_name: "some updated trading_name",
      owner_name: "some updated owner_name",
      document: "some updated document",
      address: %{"lat" => 16.8, "lng" => 28},
      coverage_area: [[[12.1, 23], [11, 11], [34, 23], [54, 76], [12.1, 23]]]
    }
    @invalid_attrs %{
      trading_name: nil,
      owner_name: nil,
      document: nil,
      address: {10.2, 20.5},
      coverage_area: [[{"asd", "dhj"}]]
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
  end
end
