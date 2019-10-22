defmodule Takemefrom.Accounts do
  import Ecto.Query, warn: false
  alias Takemefrom.Repo

  alias Takemefrom.Accounts.User

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
