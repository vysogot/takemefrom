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
end
