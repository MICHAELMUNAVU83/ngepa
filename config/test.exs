import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ngepa, Ngepa.Repo,
  username: "root",
  password: "",
  hostname: "localhost",
  database: "ngepa_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ngepa, NgepaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "q9ThKm2FHdKDP5dETRZHSxuF4e5ojSW1IBaVscBFeIU6pdtNu2kZLbMWSKE3101P",
  server: false

# In test we don't send emails.
config :ngepa, Ngepa.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
