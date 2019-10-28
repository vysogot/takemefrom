defmodule TakemefromWeb.GameChannel do
  use TakemefromWeb, :channel

  alias Takemefrom.Games

  def join("games:" <> game_session_name, _params, socket) do
    send(self(), {:after_join, game_session_name})
    {:ok, socket}
  end

  def handle_info({:after_join, game_session_name}, socket) do
    game = Games.get_by!(slug: "tutorial")

    place_node =
      game.elements
      |> Enum.find(fn x ->
        x["data"]["id"] == Integer.to_string(game.beginning_id)
      end)

    choices =
      game.elements
      |> Enum.filter(fn x ->
        x["data"]["source"] == place_node["data"]["id"]
      end)
      |> Enum.map(& &1["data"])

    push(socket, "beginning", %{place_node: place_node, choices: choices})
    {:noreply, socket}
  end
end
