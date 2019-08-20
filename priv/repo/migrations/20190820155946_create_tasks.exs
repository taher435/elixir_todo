defmodule ElixirTodo.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :status, :string
      add :due_date, :utc_datetime

      timestamps()
    end

  end
end
