defmodule ElixirTodo.RedisClient do
  use Supervisor

  @redis_connection_params
    [host: Application.get_env(:redis_client, :redis_host),
    password: Application.get_env(:redis_client, :redis_password),
    port: Application.get_env(:redis_client, :redis_port)]

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_opts = [
      name: {:local, :redix_poolboy},
      worker_module: Redix,
      size: 10,
      max_overflow: 5
    ]

    children = [
      :poolboy.child_spec(:redix_poolboy, pool_opts, @redis_connection_params)
    ]

    supervise(children, strategy: :one_for_one, name: __MODULE__)
  end

  def command(command) do
    :poolboy.transaction(:redix_poolboy, &Redix.command(&1, command))
  end

  def pipeline(commands) do
    :poolboy.transaction(:redix_poolboy, &Redix.pipeline(&1, commands))
  end

  def retrieve(key) do
    case command(["GET", key]) do
      {:ok, result} ->
        result
      _ ->
        {:error, "Could not retreive #{key}"}
    end
  end

  def insert(key, value) do
    case command(["SET", key, value]) do
      {:ok, result} ->
        result
      _ ->
        {:error, "Error inserting #{key}: #{value}"}
    end
  end
end
