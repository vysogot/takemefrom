defmodule TakemefromWeb.PlayView do
  use TakemefromWeb, :view
  alias Takemefrom.Games
  def dead_end?(choices) do
    Enum.empty?(choices)
  end

  def sanitize({ :safe, html }) do
    regex = ~r"block-->(.+?)<\/div>"
    if result = Regex.run(regex, html) do
      [_, inner] = result
      raw(inner)
    else
      html
    end
  end
end
