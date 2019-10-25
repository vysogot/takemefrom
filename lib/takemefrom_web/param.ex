defimpl Phoenix.Param, for: Takemefrom.Games.Game do
  def to_param(%{slug: slug}) do
    slug
  end
end
