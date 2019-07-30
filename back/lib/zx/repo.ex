defmodule Zx.Repo do
  use Ecto.Repo,
    otp_app: :zx,
    adapter: Ecto.Adapters.Postgres
end
