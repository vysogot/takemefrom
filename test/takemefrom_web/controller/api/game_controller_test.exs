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

  describe "unauthenticated user" do
    test "fails if user is not logged in", %{conn: conn} do
      {:ok, user} = Accounts.register_user(%{"email" => "some@other.com", "password" => "foobar"})
      game = game_fixture(user)
      conn =
        put(conn, Routes.game_path(conn, :update, game), %{
              cy: %{elements: %{nodes: [], edges: []}}
            })

      assert response(conn, 302)
      assert conn.halted
    end
  end

  describe "update/2" do
    setup %{conn: conn, login_as: email} do
      {:ok, user} = Accounts.register_user(%{"email" => email, "password" => "foobar"})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "updates elements and stores zoom, pan", %{conn: conn, user: user} do
      game = game_fixture(user)
      conn =
        put(conn, Routes.game_path(conn, :update, game), %{
              cy: %{elements: %{nodes: [], edges: []}, zoom: 1, pan: 1}
            })

      assert response(conn, 200)
    end

    @tag login_as: "user@takemefrom.com"
    test "forbids if game belongs to some other user", %{conn: conn} do
      {:ok, user} = Accounts.register_user(%{email: "someother@email.com", password: "foobar"})
      game = game_fixture(user)
      conn =
        put(conn, Routes.game_path(conn, :update, game), %{
              cy: %{elements: %{nodes: [], edges: []}, zoom: 1, pan: 1}
            })

      assert response(conn, 403)
    end
  end
end
