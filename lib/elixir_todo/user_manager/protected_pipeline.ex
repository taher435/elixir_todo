defmodule ElixirTodo.UserManager.ProtectedPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :elixir_todo,
    error_handler: ElixirTodo.UserManager.ErrorHandler

    # if there is a session token, restrict it to an access token and validate it
    plug Guardian.Plug.EnsureAuthenticated
end
