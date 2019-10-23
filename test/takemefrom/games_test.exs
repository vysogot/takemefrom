defmodule Takemefrom.GamesTest do
  use Takemefrom.DataCase

  alias Takemefrom.Games
  alias Takemefrom.Accounts

  setup do
    {:ok, user} = Accounts.register_user(%{"email" => "foo@bar", "password" => "foobar"})
    {:ok, user: user}
  end

  describe "games" do
    alias Takemefrom.Games.Game

    @valid_attrs %{
      name: "some name",
    }
    @update_attrs %{
      "cy" => %{
        "elements" => %{
          "nodes" => [],
          "edges" => []
        },
        "zoom" => 1,
        "pan" => 1
      },
      "maxElementCounter" => 1
    }

    @invalid_attrs %{
      beginning_id: nil,
      cy_options: nil,
      elements: nil,
      max_element_counter: nil,
      name: nil,
      slug: nil,
      user_id: nil
    }

    def game_fixture(user, attrs \\ %{}) do
      game_attrs = Enum.into(attrs, @valid_attrs)
      {:ok, game} = Games.create_game(user, game_attrs)
      game
    end

    test "list_games/0 returns all games", context do
      game = game_fixture(context[:user])
      assert Games.list_games() |> Enum.map(&(&1.id)) == [game.id]
    end

    test "get_game!/1 returns the game with given id", context do
      game = game_fixture(context[:user])
      assert Games.get_game!(game.id).id == game.id
    end

    test "create_game/1 with valid data creates a game", context do
      assert {:ok, %Game{} = game} = Games.create_game(context[:user], @valid_attrs)
      assert game.name == "some name"
      assert game.beginning_id == 1
      assert game.cy_options == %{}
      assert game.elements == [%{:data => %{content: "The new beginning", id: 1}, :position => %{x: 0, y: 0}}]
      assert game.max_element_counter == 1
      assert game.user_id == context[:user].id
    end

    test "create_game/1 with invalid data returns error changeset", context do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(context[:user], @invalid_attrs)
    end

    test "update_game/2 with valid data updates the game", context do
      game = game_fixture(context[:user])
      assert {:ok, %Game{} = game} = Games.update_game(context[:user], game, @update_attrs)
      assert game.cy_options == %{"zoom" => 1, "pan" => 1}
      assert game.elements == []
    end

    test "delete_game/1 deletes the game", context do
      game = game_fixture(context[:user])
      assert {:ok, %Game{}} = Games.delete_game(context[:user], game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset", context do
      game = game_fixture(context[:user])
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
