defmodule ElixirTodo.RedisClient do
  def command(command) do
    Redix.command(:redix, command)
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
      {:error, reason} ->
        IO.inspect reason
        {:error, "Error inserting #{key}: #{value}"}
    end
  end
end
