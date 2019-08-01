defmodule Zx.Business.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :trading_name,  :string
    field :owner_name,    :string
    field :document,      :string

    field :coverage_area, Geo.PostGIS.Geometry
    field :address,       Geo.PostGIS.Geometry

    field :distance,      :float, virtual: true

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:trading_name, :owner_name, :document])
    |> put_address(attrs)
    |> put_coverage_area(attrs)
    |> validate_required([:trading_name, :owner_name, :document, :coverage_area, :address])
  end

  defp put_address(changeset, %{address: %{"lat" => lat, "lng" => lng}}) do
    # Why choose SRID 4326? https://gis.stackexchange.com/questions/131363/choosing-srid-and-what-is-its-meaning
    change(changeset, address: %Geo.Point{coordinates: {lat, lng}, srid: 4326 })
  end

  defp put_address(changeset, _) do
    add_error(changeset, :address, "Invalid Format. Address must be a object with 'lat' and 'lng' properties")
  end

  defp put_coverage_area(changeset, %{coverage_area: [coverage_area]}) do
    if is_list(coverage_area) and Enum.all?(List.flatten(coverage_area), &is_number/1) do
      coverage_area = Enum.map(coverage_area, fn sublist -> Enum.map(sublist, fn [lat, lng] -> {lat, lng} end) end)
      change(changeset, coverage_area: %Geo.Polygon{coordinates: coverage_area, srid: 4326 })
    else
      add_error(changeset, :coverage_area, "Invalid Format. Coverage Area must be a list of coordinates")
    end
  end

  defp put_coverage_area(changeset, _) do
    add_error(changeset, :coverage_area, "Invalid Format. Coverage Area must be a list of coordinates")
  end

end
