defmodule TakemefromWeb.RegistrationController do
  use TakemefromWeb, :controller

  alias Takemefrom.Accounts
  alias Takemefrom.Accounts.User
  alias TakemefromWeb.Plugs.SetCurrentUser

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> SetCurrentUser.login(user)
        |> put_flash(:info, "#{user.email} created!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end
end
