defmodule TakemefromWeb.PlayView do
  use TakemefromWeb, :view
  alias Takemefrom.Games

  def dead_end?(choices) do
    Enum.empty?(choices)
  end
end
