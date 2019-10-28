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

  def handle_in("take-choice", %{"choice_id" => choice_id}, socket) do
    game = Games.get_by!(slug: "tutorial")

    new_place = Games.get_place(game, choice_id)

    push(socket, "choice-taken", new_place)
    broadcast(socket, "observe-choice", new_place)
    {:noreply, socket}
  end
end
