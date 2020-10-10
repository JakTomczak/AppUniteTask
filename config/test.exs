use Mix.Config

# Configure your database
config :app_unite, AppUnite.Repo,
  username: "postgres",
  password: "postgres",
  database: "app_unite_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :app_unite, AppUniteWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
