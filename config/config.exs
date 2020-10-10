use Mix.Config

config :app_unite,
  ecto_repos: [AppUnite.Repo],
  generators: [binary_id: true]

config :app_unite, AppUniteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9epRgdzSFKCN9qdfq6+e9Bb+I3T3/58YExxF8ir+ObwC5wm2KH0AR9tG7Yy1YvaI",
  render_errors: [view: AppUniteWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AppUnite.PubSub,
  live_view: [signing_salt: "71UNMWjC"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
