defmodule TakemefromWeb.Authorization do
  use Phoenix.Controller

  alias Takemefrom.Policy

  def authorize(conn, action_name, resource) do
    if Policy.can?(action_name, conn.assigns.current_user, resource) do
      :ok
    else
      {:error, :unauthorized}
    end
  end
end
