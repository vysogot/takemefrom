defmodule TakemefromWeb.GameCodeController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games

  plug AuthenticateUser when action in [:edit, :update]

  def edit(conn, params) do
    game = Games.get_by!(slug: params["game_id"])

    content = game.elements |> Jason.encode!(pretty: true)

    render(conn, "edit.html", game: game, content: content)
  end

  def update(conn, params) do
    game = Games.get_by!(slug: params["game_id"])

    elements = params["game"]["elements"] |> Jason.decode!()
    Games.update_elements(game, elements)

    redirect(conn, to: Routes.game_path(conn, :edit, game))
  end
end
