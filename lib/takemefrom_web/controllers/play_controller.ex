defmodule TakemefromWeb.PlayController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def show(conn, params) do
    game = Games.get_by!(slug: params["id"])

    place_node =
      game.elements
      |> Enum.find(fn x ->
        x["data"]["id"] == (params["choice"] || Integer.to_string(game.beginning_id))
      end)

    choices =
      game.elements
      |> Enum.filter(fn x ->
        x["data"]["source"] == place_node["data"]["id"]
      end)
      |> Enum.map(& &1["data"])

    render(conn, "show.html", game: game, content: place_node["data"]["content"], choices: choices)
  end
end
