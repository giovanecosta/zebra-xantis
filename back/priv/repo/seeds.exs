# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Zx.Repo.insert!(%Zx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, body} = File.read("#{:code.priv_dir(:zx)}/repo/pdvs.json")
{:ok, json} = Jason.decode(body)

Zx.Repo.delete_all(Zx.Business.Partner)

# Insert existing pdvs for easy test

for pdv <- json["pdvs"] do
  Zx.Business.create_partner(%{
    trading_name: pdv["tradingName"],
    owner_name: pdv["ownerName"],
    document: pdv["document"],
    address: %{
      "lat" => List.first(pdv["address"]["coordinates"]),
      "lng" => List.last(pdv["address"]["coordinates"])
    },
    coverage_area: pdv["coverageArea"]["coordinates"]
  })
end

# this script will generate several Partners using the 51 pdvs provided by pdvs.json and insert into database
# moving the coverage area and address randomically inside the squared area defined by the
# following points:
#
# -60.340000, -3.740000 Manaus - AM
# -42.410000, -3.740000 Luzilândia - PI
# -42.410000, -22.77000 Araruama - RJ
# -60.340000, -22.77000 Boquerón (Paraguai)
#
# Total of ~ 4.300.000 Km²

min_lat = -60.34
min_lng = -22.77

max_lat = -42.34
max_lng = -3.74

for i <- 0..5_000_000 do
  pdv = Enum.random(json["pdvs"])

  new_lat = (min_lat + (max_lat - min_lat) * :rand.uniform)
  new_lng = (min_lng + (max_lng - min_lng) * :rand.uniform)

  lat_diff = new_lat - List.first(pdv["address"]["coordinates"])
  lng_diff = new_lng - List.last(pdv["address"]["coordinates"])

  [[coverage_area]] = pdv["coverageArea"]["coordinates"]

  Zx.Business.create_partner(%{
    trading_name: "#{pdv["tradingName"]}-#{i}",
    owner_name: "#{pdv["ownerName"]}-#{i}",
    document: "#{pdv["document"]}-#{i}",
    address: %{
      "lat" => Float.round(new_lat, 5),
      "lng" => Float.round(new_lng, 5)
    },
    coverage_area: [[
      Enum.map(coverage_area, fn [lat, lng] ->
        [
          Float.round(lat + lat_diff, 5),
          Float.round(lng + lng_diff, 5)
        ]
      end)
    ]]
  })

  if rem(i, 10_000) == 0 do
    IO.puts i
  end
end
