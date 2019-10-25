defmodule TakemefromWeb.Api.GameController do
  use TakemefromWeb, :controller

  alias Takemefrom.Games
  alias TakemefromWeb.Authorization

  plug AuthenticateUser when action in [:update]

  def show(conn, params) do
    game = Games.get_by!(slug: params["id"])

    render(conn, "show.json", game: game)
  end

  def update(conn, params) do
    game = Games.get_by!(slug: params["id"])

    with :ok <- Authorization.authorize(conn, :edit, game) do
      {:ok, game} = Games.update_game(game, params)
      render(conn, "show.json", game: game)
    end
  end
end
