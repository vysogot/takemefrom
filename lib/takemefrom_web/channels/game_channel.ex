defmodule TakemefromWeb.GameChannel do
  use TakemefromWeb, :channel

  def join("games:" <> _game_name, _params, socket) do
    {:ok, socket}
  end
end
