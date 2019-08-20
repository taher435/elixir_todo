defmodule ElixirTodo.TaskManager.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :due_date, :utc_datetime
    field :status, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :status, :due_date])
    |> validate_required([:title, :status, :due_date])
  end
end
