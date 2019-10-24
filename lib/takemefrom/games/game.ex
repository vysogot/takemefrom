defmodule Takemefrom.Games.Game do
  @moduledoc false

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
    |> cast(attrs, [
      :name,
      :slug,
      :user_id,
      :beginning_id,
      :max_element_counter,
      :cy_options,
      :elements
    ])
    |> validate_required([
      :name,
      :user_id,
      :beginning_id,
      :max_element_counter,
      :cy_options,
      :elements
    ])
  end

  @doc false
  def create_changeset(game, attrs) do
    game
    |> cast(attrs, [
      :name,
      :slug,
      :user_id,
      :beginning_id,
      :max_element_counter,
      :cy_options,
      :elements
    ])
    |> validate_required([:name])
    |> slugify_attr(:name)
    |> validate_required([:slug])
  end

  defp slugify_attr(changeset, attr) do
    case fetch_change(changeset, attr) do
      {:ok, changed_attr} -> put_change(changeset, :slug, slugify(changed_attr))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
