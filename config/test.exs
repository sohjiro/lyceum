use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lyceum, Lyceum.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :lyceum, Lyceum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "lyceum_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :lyceum, Lyceum.Mailer,
  adapter: Swoosh.Adapters.Local

config :lyceum,
  remitent: {"test", "test@lyceum.com"},
  bcc: ["admin1@lyceum.com", "admin2@lyceum.com"]
