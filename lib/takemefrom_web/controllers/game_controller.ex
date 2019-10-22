defmodule TakemefromWeb.GameController do
  use TakemefromWeb, :controller
  alias Takemefrom.Games

  plug AuthenticateUser when action in [:index, :edit]

  def index(conn, _params) do
    games = Games.list_games()

    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    game = Games.create_game(conn.assigns.current_user, params["games"])

    case game do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created!")
        |> redirect(to: Routes.game_path(conn, :edit, game))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid game name")
        |> render("new.html")
    end
  end

  def edit(conn, params) do
    game = Games.get_game!(params["id"])

    elements = game.elements |> Jason.encode!()
    cy_options = game.elements |> Jason.encode!()

    render(conn, "edit.html", game: game, elements: elements, cy_options: cy_options)
  end
end
