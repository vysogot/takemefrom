defmodule Takemefrom.Repo.Migrations.AddUniqueConstraints do
  use Ecto.Migration

  def change do
    create index("users", [:email], unique: true)
    create index("games", [:slug], unique: true)
  end
end
