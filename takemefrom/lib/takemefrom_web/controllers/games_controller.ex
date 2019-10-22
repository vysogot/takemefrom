defmodule TakemefromWeb.GamesController do
  use TakemefromWeb, :controller
  alias Takemefrom.Games

  plug AuthenticateUser when action in [:index, :edit]

  def index(conn, _params) do
    games = Games.list_games

    render(conn, "index.html", games: games)
  end

  def edit(conn, params) do
    game = Games.get_game!(params["id"])

    elements = game.elements |> Jason.encode!
    cy_options = game.elements |> Jason.encode!

    render(conn, "edit.html", game: game, elements: elements, cy_options: cy_options)
  end
end
