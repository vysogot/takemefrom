defmodule TakemefromWeb.PlayView do
  use TakemefromWeb, :view
  alias Takemefrom.Games
  def dead_end?(choices) do
    Enum.empty?(choices)
  end

  def sanitize({ :safe, html }) do
    regex = ~r"block-->(.+?)<\/div>"
    [_, inner] = Regex.run(regex, html)
    raw(inner)
  end
end
