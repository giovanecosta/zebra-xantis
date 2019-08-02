defmodule Zx.Business.PartnerHelpers do

  def geojson_translate(map) when is_map(map) do
    map
    |> Enum.map(fn {k, v} ->
      case v do
        %{"type" => "MultiPolygon"} ->
          {k, v["coordinates"]}
        %{"type" => "Point", "coordinates" => [lat, lng]} ->
          {k, %{"lat" => lat, "lng" => lng}}
        _ -> {k, v}
      end
    end)
    |> Enum.into(%{})
  end

  def map_keys_to_atom(map) do
    Map.new(map, fn {k, v} -> {String.to_atom(Macro.underscore(k)), v} end)
  end

end
