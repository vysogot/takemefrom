defmodule TakemefromWeb.GamesController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def edit(conn, params) do
    game = Games.get_game!(params["id"])

    elements = game.elements |> Jason.encode!
    cy_options = game.elements |> Jason.encode!

    render(conn, "edit.html", game: game, elements: elements, cy_options: cy_options)
  end
end
