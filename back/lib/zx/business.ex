defmodule Zx.Business do
  @moduledoc """
  The Business context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Zx.Repo

  alias Zx.Business.Partner

  @doc """
  Returns the list of partners.

  ## Examples

      iex> list_partners()
      [%Partner{}, ...]

  """
  def list_partners do
    Repo.all(Partner)
  end

  @doc """
  Returns the nearest partner given a specific location.

  ## Examples

      iex> get_nearest_partner(-44.23523, -22.345622)
      %Partner{}

  """
  def get_nearest_partner(lat, lng) do
    point = %Geo.Point{coordinates: {lat, lng}, srid: 4326}

    query = from p in Partner,
              limit: 1,
              order_by: st_distance(p.address, ^point),
              select: %{p | distance: st_distance(p.address, ^point)}
    Repo.all(query)
  end

  @doc """
  Returns the list of partners covering a given point.

  ## Examples

      iex> get_covering_partners(-44.23523, -22.345622)
      [%Partner{}, ...]

  """
  def list_covering_partners(lat, lng) do
    point = %Geo.Point{coordinates: {lat, lng}, srid: 4326}

    query = from p in Partner,
              where: st_contains(p.coverage_area, ^point),
              select: p
              #select: %{p | distance: st_distance(p.address, ^point)}
    Repo.all(query)
  end

  @doc """
  Gets a single partner.

  Raises `Ecto.NoResultsError` if the Partner does not exist.

  ## Examples

      iex> get_partner!(123)
      %Partner{}

      iex> get_partner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partner!(id), do: Repo.get!(Partner, id)

  @doc """
  Creates a partner.

  ## Examples

      iex> create_partner(%{field: value})
      {:ok, %Partner{}}

      iex> create_partner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partner.

  ## Examples

      iex> update_partner(partner, %{field: new_value})
      {:ok, %Partner{}}

      iex> update_partner(partner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partner(%Partner{} = partner, attrs) do
    partner
    |> Partner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Partner.

  ## Examples

      iex> delete_partner(partner)
      {:ok, %Partner{}}

      iex> delete_partner(partner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partner(%Partner{} = partner) do
    Repo.delete(partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partner changes.

  ## Examples

      iex> change_partner(partner)
      %Ecto.Changeset{source: %Partner{}}

  """
  def change_partner(%Partner{} = partner) do
    Partner.changeset(partner, %{})
  end
end
