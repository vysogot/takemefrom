defmodule TakemefromWeb.GameControllerTest do
  use TakemefromWeb.ConnCase

  test "fails if user is not logged in", %{conn: conn} do
    Enum.each(
      [
        get(conn, Routes.game_path(conn, :new)),
        post(conn, Routes.game_path(conn, :create)),
        get(conn, Routes.game_path(conn, :edit, "1")),
        delete(conn, Routes.game_path(conn, :delete, "1"))
      ],
      fn conn ->
        assert response(conn, 302)
        assert conn.halted
      end
    )
  end

  describe "index/2" do
    test "returns 200", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :index))

      assert response(conn, 200)
    end
  end

  describe "new/2" do
    setup %{conn: conn, login_as: email} do
      user = user_fixture(%{email: email})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "returns 200", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :new))

      assert response(conn, 200)
    end
  end

  describe "create/2" do
    setup %{conn: conn, login_as: email} do
      user = user_fixture(%{email: email})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "returns 302", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), %{games: %{name: "some new game"}})

      assert response(conn, 302)
    end
  end

  describe "edit/2" do
    setup %{conn: conn, login_as: email} do
      user = user_fixture(%{email: email})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "returns 200", %{conn: conn, user: user} do
      game = game_fixture(user)
      conn = get(conn, Routes.game_path(conn, :edit, game))

      assert response(conn, 200)
    end
  end

  describe "delete/2" do
    setup %{conn: conn, login_as: email} do
      user = user_fixture(%{email: email})
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "user@takemefrom.com"
    test "returns 200", %{conn: conn, user: user} do
      game = game_fixture(user)
      conn = delete(conn, Routes.game_path(conn, :delete, game))

      assert response(conn, 302)
    end
  end
end
