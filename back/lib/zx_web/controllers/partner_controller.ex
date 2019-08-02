defmodule ZxWeb.PartnerController do
  use ZxWeb, :controller

  alias Zx.Business
  alias Zx.Business.Partner

  import Zx.Business.PartnerHelpers

  action_fallback ZxWeb.FallbackController

  def index(conn, _params) do
    partners = Business.list_partners()
    render(conn, "index.json", partners: partners)
  end

  def search_by_location(conn, %{"lat" => lat, "lng" => lng}) do
    partners = Business.list_covering_partners(lat, lng)
    render(conn, "index.json", partners: partners)
  end

  def get_nearest_covering(conn, %{"lat" => lat, "lng" => lng}) do
    partner = Business.get_nearest_partner(lat, lng, true)
    render(conn, "show.json", partner: partner)
  end

  def create(conn, %{"partner" => partner_params}) do
    partner_params = partner_params
    |> geojson_translate
    |> map_keys_to_atom
    with {:ok, %Partner{} = partner} <- Business.create_partner(partner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.partner_path(conn, :show, partner))
      |> render("show.json", partner: partner)
    end
  end

  def show(conn, %{"id" => id}) do
    partner = Business.get_partner!(id)
    render(conn, "show.json", partner: partner)
  end

  def update(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Business.get_partner!(id)

    partner_params = partner_params
    |> geojson_translate
    |> map_keys_to_atom

    with {:ok, %Partner{} = partner} <- Business.update_partner(partner, partner_params) do
      render(conn, "show.json", partner: partner)
    end
  end

  def delete(conn, %{"id" => id}) do
    partner = Business.get_partner!(id)

    with {:ok, %Partner{}} <- Business.delete_partner(partner) do
      send_resp(conn, :no_content, "")
    end
  end
end
