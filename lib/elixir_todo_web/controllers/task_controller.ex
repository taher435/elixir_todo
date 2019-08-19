defmodule ElixirTodoWeb.TaskController do
  use ElixirTodoWeb, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    text(conn, "List of all tasks")
  end
end
