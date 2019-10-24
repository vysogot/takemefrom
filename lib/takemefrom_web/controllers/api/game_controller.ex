defmodule TakemefromWeb.Api.GameController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games
  alias TakemefromWeb.Authorization

  plug AuthenticateUser when action in [:update]

  def update(conn, params) do
    game = Games.get_game!(params["id"])
    with :ok <- Authorization.authorize(conn, :edit, game) do
      Games.update_game(game, params)
      send_resp(conn, 200, "")
    end
  end
end
