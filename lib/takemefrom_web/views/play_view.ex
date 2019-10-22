defmodule TakemefromWeb.PlayView do
  use TakemefromWeb, :view

  def dead_end?(choices) do
    Enum.empty?(choices)
  end
end
