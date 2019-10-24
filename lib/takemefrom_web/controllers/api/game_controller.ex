defmodule TakemefromWeb.Api.GameController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games
  alias TakemefromWeb.Authorization

  def update(conn, params) do
    game = Games.get_game!(params["id"])
    Authorization.authorize(conn, :edit, game)

    Games.update_game(game, params)
    send_resp(conn, 200, "")
  end
end
