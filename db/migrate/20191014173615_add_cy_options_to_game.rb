class AddCyOptionsToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :cy_options, :jsonb
  end
end
