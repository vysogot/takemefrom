class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name,
      t.string :slug,
      t.int, :user_id
      t.int :beginning_id

      t.timestamps
    end
  end
end
