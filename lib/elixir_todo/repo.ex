defmodule ElixirTodo.Repo do
  use Ecto.Repo,
    otp_app: :elixir_todo,
    adapter: Ecto.Adapters.Postgres
end
