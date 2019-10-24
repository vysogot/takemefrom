defmodule TakemefromWeb.Api.GameControllerTest do
  use TakemefromWeb.ConnCase

  alias Takemefrom.Accounts
  alias Takemefrom.Games

  def game_fixture(user, attrs \\ %{}) do
    valid_attrs = %{name: "Some game"}
    game_attrs = Enum.into(attrs, valid_attrs)
    {:ok, game} = Games.create_game(user, game_attrs)
    game
  end

  describe "update/2" do
    setup do
      {:ok, user} = Accounts.register_user(%{"email" => "foo@bar", "password" => "foobar"})
      game = game_fixture(user)
      {:ok, game: game}
    end

    test "fails if user is not logged in", %{conn: conn, game: game} do
      conn = put(conn, Routes.game_path(conn, :update, game), %{cy: %{elements: %{nodes: [], edges: []}}})

      assert response(conn, 302)
      assert conn.halted
    end
  end
end
