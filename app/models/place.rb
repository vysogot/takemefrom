class Place < ApplicationRecord
  belongs_to :game
  has_many :actions, foreign_key: "source_id"
  has_many :destinations, through: :actions

  def create_destination(action_content, destination_content)
    destination = Place.create(game: game, content: destination_content)
    Action.create(source: self, target: destination, content: action_content)
    destination
  end
end
