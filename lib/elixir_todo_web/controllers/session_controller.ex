defmodule ElixirTodoWeb.SessionController do
  use ElixirTodoWeb, :controller
  require IEx

  alias ElixirTodo.{UserManager, UserManager.User, UserManager.Guardian}

  def new(conn, _) do
    changeset = UserManager.change_user(%User{})
    user = Guardian.Plug.current_resource(conn)

    if user do
      redirect(conn, to: Routes.task_path(conn, :index))
    else
      conn
      |> assign(:changeset, changeset)
      |> assign(:submit_to, Routes.session_path(conn, :login))
      |> render("login.html")
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    UserManager.authenticate_user(username, password)
    |> login_handler(conn)
  end

  defp login_handler({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome #{user.name}")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.task_path(conn, :index))
  end

  defp login_handler({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
