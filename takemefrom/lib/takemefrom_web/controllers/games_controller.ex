defmodule TakemefromWeb.GamesController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def edit(conn, params) do
    game = Games.get_game!(params["id"])

    render(conn, "edit.html", game: game)
  end
end
