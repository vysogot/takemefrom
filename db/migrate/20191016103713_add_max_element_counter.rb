class AddMaxElementCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :max_element_counter, :integer, null: false, default: 1
  end
end
