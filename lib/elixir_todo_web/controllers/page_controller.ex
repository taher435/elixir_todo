defmodule ElixirTodoWeb.PageController do
  use ElixirTodoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
