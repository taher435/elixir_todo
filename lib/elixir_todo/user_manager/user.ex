defmodule ElixirTodo.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_attributes ~w(name email username password)a
  @attributes ~w(name email username password)a

  schema "users" do
    field :password, :string
    field :username, :string
    field :name, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
