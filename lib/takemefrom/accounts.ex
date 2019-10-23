defmodule Takemefrom.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Takemefrom.Repo

  alias Takemefrom.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by(opts) do
    Repo.get_by(User, opts)
  end

  def authenticate_by_email_and_pass(email, given_pass) do
    user = get_user_by(email: email)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.encrypted_password) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
