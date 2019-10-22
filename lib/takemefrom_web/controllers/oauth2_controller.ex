defmodule TakemefromWeb.Oauth2Controller do
  use TakemefromWeb, :controller

  alias Takemefrom.GitHub

  def github(conn, _params) do
    redirect(conn, external: GitHub.authorize_url!())
  end
end
