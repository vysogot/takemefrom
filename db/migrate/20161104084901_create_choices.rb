class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.integer :game_id
      t.integer :source_id
      t.integer :target_id
      t.string :content

      t.timestamps
    end
  end
end
