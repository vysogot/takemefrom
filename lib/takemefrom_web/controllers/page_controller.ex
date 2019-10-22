defmodule TakemefromWeb.PageController do
  use TakemefromWeb, :controller
  alias Takemefrom.Games

  def index(conn, _params) do
    game = Games.get_by_name!("Tutorial")

    render(conn, "index.html", game: game)
  end
end
