defmodule TakemefromWeb.GameCodeController do
  use TakemefromWeb, :controller

  plug AuthenticateUser when action in [:edit, :update]

  def edit(conn, params) do
    game = Games.get_by!(slug: params["id"])

    render(conn, "edit.html.erb", game: game)
  end

  def update(conn, params) do
    game = Games.get_by!(slug: params["id"])

    GameCodeLang.evaluate(params["code"])
    redirect(conn, to: Routes.game_path(conn, :edit, game))
  end
end
