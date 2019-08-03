defmodule ZxWeb.PartnerView do
  use ZxWeb, :view
  alias ZxWeb.PartnerView

  def render("index.json", %{partners: partners}) do
    %{data: render_many(partners, PartnerView, "partner.json")}
  end

  def render("show.json", %{partner: partner}) do
    %{data: render_one(partner, PartnerView, "partner.json")}
  end

  def render("partner.json", %{partner: partner}) do
    %{id: partner.id,
      tradingName: partner.trading_name,
      ownerName: partner.owner_name,
      document: partner.document,
      distance: partner.distance,
      coverageArea: %{
        type: "MultiPolygon",
        coordinates: Enum.map(partner.coverage_area.coordinates, fn sublist ->
          Enum.map(sublist, fn subsublist ->
            Enum.map(subsublist, &Tuple.to_list/1)
          end)
        end)
      },
      address: %{
        type: "Point",
        coordinates: Tuple.to_list(partner.address.coordinates)
      }
    }
  end
end
