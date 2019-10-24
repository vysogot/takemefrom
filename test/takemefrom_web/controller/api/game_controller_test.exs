defmodule TakemefromWeb.Api.GameControllerTest do
  use TakemefromWeb.ConnCase

  test "fails if user is not logged in", %{conn: conn} do
    Enum.each(
      [
        put(conn, Routes.game_path(conn, :update, "1"), %{
          cy: %{elements: %{nodes: [], edges: []}}
        })
      ],
      fn conn ->
        assert response(conn, 302)
        assert conn.halted
      end
    )
  end

  describe "update/2" do
    setup %{conn: conn, login_as: email} do
      user = user_fixture(%{email: email})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "updates elements and stores zoom, pan", %{conn: conn, user: user} do
      game = game_fixture(user)

      conn =
        put(conn, Routes.game_path(conn, :update, game), %{
          maxElementCounter: 1,
          cy: %{elements: %{nodes: [], edges: []}, zoom: 1, pan: 1}
        })

      assert response(conn, 200)
    end

    @tag login_as: "user@takemefrom.com"
    test "forbids if game belongs to some other user", %{conn: conn} do
      user = user_fixture(%{email: "someother@email.com"})
      game = game_fixture(user)

      conn =
        put(conn, Routes.game_path(conn, :update, game), %{
          cy: %{elements: %{nodes: [], edges: []}, zoom: 1, pan: 1}
        })

      assert response(conn, 403)
    end
  end
end
