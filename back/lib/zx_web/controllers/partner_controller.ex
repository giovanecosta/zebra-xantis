defmodule ZxWeb.PartnerController do
  use ZxWeb, :controller

  alias Zx.Business
  alias Zx.Business.Partner

  action_fallback ZxWeb.FallbackController

  def index(conn, _params) do
    partners = Business.list_partners()
    render(conn, "index.json", partners: partners)
  end

  def create(conn, %{"partner" => partner_params}) do

    with {:ok, %Partner{} = partner} <- Business.create_partner(map_keys_to_atom(partner_params)) do
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

    with {:ok, %Partner{} = partner} <- Business.update_partner(partner, map_keys_to_atom(partner_params)) do
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
