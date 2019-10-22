defmodule Takemefrom.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Takemefrom.Repo

  alias Takemefrom.Games.Game
  alias Takemefrom.Accounts.User
  alias Ecto.Changeset

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)
  def get_by_name!(name), do: Repo.get_by!(Game, name: name)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(%User{} = user, attrs \\ %{}) do
    attrs = Map.put(attrs, "user_id", user.id)

    %Game{}
    |> Game.create_changeset(attrs)
    |> Changeset.change(
      elements: [%{
          data: %{ id: 1, content: "The new beginning" },
          position: %{ x: 0, y: 0 }
        }],
      beginning_id: 1,
      cy_options: %{},
      max_element_counter: 1
    )
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    nodes = Enum.map(attrs["cy"]["elements"]["nodes"], fn node ->
      Map.take(node, ["data", "position"])
    end)

    edges = Enum.map(attrs["cy"]["elements"]["edges"], fn edge ->
      Map.take(edge, ["data", "position"])
    end)

    update_attrs = %{
      "elements" => nodes ++ edges,
      "cy_options" => Map.take(attrs["cy"], ["zoom", "pan"]),
      "max_element_counter" => attrs["maxElementCounter"]
    }

    game
    |> Game.changeset(update_attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{source: %Game{}}

  """
  def change_game(%Game{} = game) do
    Game.changeset(game, %{})
  end

  def editable?(%Game{} = game, %User{} = user) do
     game.user == user || user.email == "admin@takemefrom.com"
  end

  def editable?(_, nil), do: false
end
