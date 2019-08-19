defmodule ElixirTodoWeb.Router do
  use ElixirTodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  pipeline :auth do
    plug ElixirTodo.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    # plug ElixirTodo.UserManager.ProtectedPipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  # accessible without login
  scope "/", ElixirTodoWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
  end

  # accessible with login
  scope "/", ElixirTodoWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/tasks", TaskController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirTodoWeb do
  #   pipe_through :api
  # end
end
