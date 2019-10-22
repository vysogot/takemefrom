defmodule Takemefrom.GamesTest do
  use Takemefrom.DataCase

  alias Takemefrom.Games

  describe "games" do
    alias Takemefrom.Games.Game

    @valid_attrs %{
      beginning_id: 42,
      cy_options: %{},
      elements: %{},
      max_element_counter: 42,
      name: "some name",
      slug: "some slug",
      user_id: 42
    }
    @update_attrs %{
      beginning_id: 43,
      cy_options: %{},
      elements: %{},
      max_element_counter: 43,
      name: "some updated name",
      slug: "some updated slug",
      user_id: 43
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

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.beginning_id == 42
      assert game.cy_options == %{}
      assert game.elements == %{}
      assert game.max_element_counter == 42
      assert game.name == "some name"
      assert game.slug == "some slug"
      assert game.user_id == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.beginning_id == 43
      assert game.cy_options == %{}
      assert game.elements == %{}
      assert game.max_element_counter == 43
      assert game.name == "some updated name"
      assert game.slug == "some updated slug"
      assert game.user_id == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
