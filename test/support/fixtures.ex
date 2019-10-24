defmodule Takemefrom.Fixtures do
  alias Takemefrom.Games
  alias Takemefrom.Accounts

  def user_fixture(attrs \\ %{}) do
    valid_attrs = %{email: "user@takemefrom.com", password: "foobar"}
    user_attrs = Enum.into(attrs, valid_attrs)
    {:ok, user} = Accounts.register_user(user_attrs)
    user
  end

  def game_fixture(user, attrs \\ %{}) do
    valid_attrs = %{name: "some name"}
    game_attrs = Enum.into(attrs, valid_attrs)
    {:ok, game} = Games.create_game(user, game_attrs)
    game
  end
end
