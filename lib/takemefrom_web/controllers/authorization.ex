defmodule TakemefromWeb.Authorization do
  use Phoenix.Controller

  alias Takemefrom.Policy

  def authorize(conn, action_name, resource) do
    if !Policy.can?(action_name, conn.assigns.current_user, resource) do
      send_resp(conn, 403, "You are not authorized to do this.")
      |> halt()
    end
  end
end
