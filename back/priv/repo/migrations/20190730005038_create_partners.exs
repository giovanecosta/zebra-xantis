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
  end

  def down do
    drop index(:partners, [:document])
    drop table(:partners)

    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
