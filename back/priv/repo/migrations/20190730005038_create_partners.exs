defmodule Zx.Repo.Migrations.CreatePartners do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"

    create table(:partners) do
      add :trading_name,  :string
      add :owner_name,    :string
      add :document,      :string

      add :coverage_area, :geometry
      add :address,       :geometry

      timestamps()
    end

    create unique_index(:partners, [:document])

    execute "CREATE INDEX partners_coverage_area_idx ON partners USING GIST (coverage_area)"
    execute "CREATE INDEX partners_address_idx ON partners USING GIST (address)"
  end

  def down do
    drop index(:partners, [:document])
    drop table(:partners)

    execute "DROP EXTENSION IF EXISTS postgis"
    execute "DROP INDEX partners_coverage_area_idx"
    execute "DROP INDEX partners_address_idx"
  end
end
