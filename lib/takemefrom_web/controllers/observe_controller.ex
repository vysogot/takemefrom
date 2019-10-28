defmodule TakemefromWeb.ObserveController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  def show(conn, params) do
    game = Games.get_by!(slug: params["game_id"])

    conn
    |> assign(:elements, game.elements |> Jason.encode!())
    |> assign(:cy_options, game.cy_options |> Jason.encode!())
    |> assign(:beginning_id, game.beginning_id |> Jason.encode!())
    |> render("show.html")
  end
end
