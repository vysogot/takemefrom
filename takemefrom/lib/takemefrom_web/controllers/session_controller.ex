defmodule TakemefromWeb.SessionController do
  use TakemefromWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(_conn, _params) do
  end

  def destroy(_conn, _params) do
  end
end
