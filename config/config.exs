# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app_unite,
  ecto_repos: [AppUnite.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :app_unite, AppUniteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9epRgdzSFKCN9qdfq6+e9Bb+I3T3/58YExxF8ir+ObwC5wm2KH0AR9tG7Yy1YvaI",
  render_errors: [view: AppUniteWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AppUnite.PubSub,
  live_view: [signing_salt: "71UNMWjC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
