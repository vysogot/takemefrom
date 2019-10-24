defmodule Takemefrom.PolicyTest do
  use Takemefrom.DataCase

  alias Takemefrom.Accounts.User
  alias Takemefrom.Games.Game
  alias Takemefrom.Policy

  @admin_user %User{id: 1, email: "admin@takemefrom.com"}

  @user %User{id: 2, email: "user@takemefrom.com"}
  @user2 %User{id: 3, email: "other@takemefrom.com"}

  @game %Game{name: "some", user_id: @user.id}

  test Policy do
    assert Policy.can?(:edit, @admin_user, @game)
    assert Policy.can?(:edit, @user, @game)
    refute Policy.can?(:edit, @user2, @game)
  end
end
