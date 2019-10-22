defmodule Takemefrom.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :slug, :string
      add :user_id, :integer
      add :beginning_id, :integer
      add :max_element_counter, :integer
      add :cy_options, :map
      add :elements, :map

      timestamps()
    end
  end
end
