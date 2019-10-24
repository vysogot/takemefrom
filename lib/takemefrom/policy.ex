defmodule Takemefrom.Policy do
  @moduledoc false

  alias Takemefrom.Accounts.User

  alias Takemefrom.Games.Game

  def can?(_, %User{email: "admin@takemefrom.com"} = _user, _) do
    true
  end

  def can?(:edit, %User{} = user, %Game{} = game) do
    user.id == game.user_id
  end

  def can?(_action, _user, _resource) do
    false
  end
end
