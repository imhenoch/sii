use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sii, SiiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sii, Sii.Repo,
  username: "postgres",
  password: "postgres",
  database: "sii_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
