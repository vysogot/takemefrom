defmodule TakemefromWeb.Api.GameController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def update(conn, params) do
    game = Games.get_game!(params["id"])

    case Games.update_game(conn.assigns.current_user, game, params) do
      {:ok, _} -> send_resp(conn, 200, "")
      false -> send_resp(conn, 401, "Can't be done")
    end
  end
end
