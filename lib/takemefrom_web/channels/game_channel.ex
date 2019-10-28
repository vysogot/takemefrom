defmodule TakemefromWeb.GameChannel do
  use TakemefromWeb, :channel

  alias Takemefrom.Games

  def join("games:" <> game_session_name, _params, socket) do
    send(self(), {:after_join, game_session_name})
    {:ok, socket}
  end

  def handle_info({:after_join, game_session_name}, socket) do
    game = Games.get_by!(slug: "tutorial")

    initial_state = Games.get_beginning(game)

    push(socket, "beginning", initial_state)
    {:noreply, socket}
  end
end
