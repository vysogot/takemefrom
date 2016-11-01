class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.int, :game_id
      t.string :content

      t.timestamps
    end
  end
end
