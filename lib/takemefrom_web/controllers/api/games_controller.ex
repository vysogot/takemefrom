defmodule TakemefromWeb.Api.GamesController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def update(conn, params) do
    game = Games.get_game!(params["id"])
    {:ok, _} = game |> Games.update_game(params)

    send_resp(conn, 200, "")
  end
end
