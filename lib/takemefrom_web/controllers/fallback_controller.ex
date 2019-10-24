defmodule TakemefromWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> send_resp(403, "You are not permitted to access this resource.")
  end
end
