defmodule ElixirTodo.UserManager.Guardian do
  use Guardian, otp_app: :elixir_todo

  alias ElixirTodo.UserManager

  # used to encode the resource into the token
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  # used to rehydrate the resource from the claims.
  def resource_from_claims(%{"sub" => id}) do
    case UserManager.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
