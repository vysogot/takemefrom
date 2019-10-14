class AddElementsToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :elements, :jsonb
  end
end
