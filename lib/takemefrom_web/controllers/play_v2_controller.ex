defmodule TakemefromWeb.PlayV2Controller do
  use TakemefromWeb, :controller

  def show(conn, params) do
    token = Phoenix.Token.sign(TakemefromWeb.Endpoint, "user salt", :rand.uniform(9999))

    conn
    |> assign(:token, token)
    |> assign(:game_name, params["id"])
    |> render("show.html")
  end
end
