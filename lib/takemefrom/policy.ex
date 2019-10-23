defmodule Takemefrom.Policy do
  @moduledoc false

  alias Takemefrom.Accounts.User

  alias Takemefrom.Games.Game
  def can?(:edit, %User{} = user, %Game{} = game), do: user.id == game.user_id

  def can?(_action, _user, _resource) do
    true
  end
end
