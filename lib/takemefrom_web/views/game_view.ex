defmodule TakemefromWeb.GameView do
  use TakemefromWeb, :view
  alias Takemefrom.Games

  def render("styles.edit.html", assigns) do
    ~E"""
      <link rel="stylesheet" href="<%= Routes.static_path(@conn, "/css/GameEditor.css") %>"/>
    """
  end

  def render("scripts.edit.html", assigns) do
    ~E"""
      <script src="<%= Routes.static_path(@conn, "/js/GameEditor.js") %>"></script>
    """
  end
end
