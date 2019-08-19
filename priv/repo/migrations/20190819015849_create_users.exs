defmodule ElixirTodo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :password, :string
      add :email, :string

      timestamps()
    end

  end
end
