# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zx,
  ecto_repos: [Zx.Repo]

# Configures the endpoint
config :zx, ZxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qc8/fx5OP+bR6S5BjWX61AOaiPfQtwK7ASqatLp7Alh6DYenZHEOeG+le7TpVfsj",
  render_errors: [view: ZxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Zx.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
