defmodule TakemefromWeb.SessionController do
  use TakemefromWeb, :controller
  alias Takemefrom.Accounts
  alias TakemefromWeb.Sessions

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Accounts.authenticate_by_email_and_pass(email, pass) do
      {:ok, user} ->
        conn
        |> Sessions.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Sessions.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
