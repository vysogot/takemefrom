class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.int :game_id
      t.int :source_id
      t.int :target_id
      t.string :content

      t.timestamps
    end
  end
end
