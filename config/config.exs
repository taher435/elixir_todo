# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_todo,
  ecto_repos: [ElixirTodo.Repo]

# Configures the endpoint
config :elixir_todo, ElixirTodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oV898RVCFSumNPkGUZ0Qu7EH/fo75fndC4NpfaoG9VR6wecl8C7udbKJAZfWFnPN",
  render_errors: [view: ElixirTodoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirTodo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_todo, ElixirTodo.UserManager.Guardian,
  issuer: "elixir_todo",
  secret_key: "48sslLhlnVpc9qz9PZ+H1yNy6pPUMzAZHcaJWADYrOJ76km5yo4TKxHvcAO+8y+/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
