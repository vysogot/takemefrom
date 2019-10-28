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

    case params["game"]["elements"] |> Jason.decode() do
      {:ok, elements} ->
        Games.update_elements(game, elements)

        conn
        |> put_flash(:notice, "Your game has been created!")
        |> redirect(to: Routes.game_path(conn, :edit, game))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid JSON provided")
        |> render("edit.html", game: game, content: params["game"]["elements"])
    end
  end
end
