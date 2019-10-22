defmodule TakemefromWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias TakemefromWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _params) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
