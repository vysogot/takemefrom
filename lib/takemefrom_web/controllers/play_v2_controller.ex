defmodule TakemefromWeb.PlayV2Controller do
  use TakemefromWeb, :controller

  def show(conn, params) do
    token = Phoenix.Token.sign(conn, "player_salt", %{
      player_id: :rand.uniform(9999),
      game_slug: params["game_id"]
    })

    conn
    |> assign(:token, token)
    |> assign(:game_session_name, params["id"])
    |> assign(:game_slug, params["game_id"])
    |> render("show.html")
  end
end
