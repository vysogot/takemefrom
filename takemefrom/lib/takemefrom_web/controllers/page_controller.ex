defmodule TakemefromWeb.PageController do
  use TakemefromWeb, :controller
  alias Takemefrom.Games

  def index(conn, _params) do
    game = Games.get_by_name!("Tutorial")
    user = conn.assigns[:current_user]

    render(conn, "index.html", game: game, user: user)
  end
end
