defmodule TakemefromWeb.Api.GameView do
  use TakemefromWeb, :view
  alias Takemefrom.Games

  def render("show.json", %{game: game}) do
    render_one(game, __MODULE__, "game.json")
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      name: game.name,
      slug: game.slug,
      elements: game.elements,
      isTouched: Games.touched?(game),
      beginningId: game.beginning_id,
      cyOptions: game.cy_options,
      maxElementCounter: game.max_element_counter,
      insertedAt: game.inserted_at,
      updatedAt: game.updated_at
    }
  end
end
