defmodule TakemefromWeb.GameChannel do
  use TakemefromWeb, :channel

  alias Takemefrom.Games

  def join("games:" <> game_session_name, _params, socket) do
    send(self(), {:after_join, game_session_name})
    {:ok, socket}
  end

  def handle_info({:after_join, _game_session_name}, socket) do
    game = Games.get_by!(slug: socket.assigns.game_slug)

    initial_state = Games.get_beginning(game)

    push(socket, "beginning", initial_state)
    if !socket.assigns.observer do
      broadcast(socket, "observe-choice", %{ new_place: initial_state.place, choice_id: 0 })
    end

    {:noreply, socket}
  end

  def handle_in("take-choice", %{"choice_id" => choice_id, "target_id" => target_id}, socket) do
    game = Games.get_by!(slug: socket.assigns.game_slug)

    new_place = Games.get_place(game, target_id)

    push(socket, "choice-taken", new_place)
    broadcast(socket, "observe-choice", %{ new_place: new_place.place, choice_id: choice_id })
    {:noreply, socket}
  end
end
