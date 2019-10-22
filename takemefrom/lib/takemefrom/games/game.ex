defmodule Takemefrom.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :beginning_id, :integer
    field :cy_options, :map
    field :elements, {:array, :map}
    field :max_element_counter, :integer
    field :name, :string
    field :slug, :string

    timestamps()

    belongs_to :user, Takemefrom.Accounts.User
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :slug, :user_id, :beginning_id, :max_element_counter, :cy_options, :elements])
    |> validate_required([:name, :user_id, :beginning_id, :max_element_counter, :cy_options, :elements])
  end

  @doc false
  def create_changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :slug, :user_id, :beginning_id, :max_element_counter, :cy_options, :elements])
    |> validate_required([:name, :user_id])
  end
end
