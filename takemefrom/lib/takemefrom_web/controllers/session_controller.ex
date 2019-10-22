defmodule TakemefromWeb.SessionController do
  use TakemefromWeb, :controller
  alias Takemefrom.Accounts
  alias TakemefromWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(:index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def destroy(_conn, _params) do
  end
end
