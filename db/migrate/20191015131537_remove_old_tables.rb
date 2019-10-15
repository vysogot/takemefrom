class RemoveOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :places
    drop_table :choices
  end
end
