class Place < ApplicationRecord
  belongs_to :game
  has_many :choices, foreign_key: "source_id", dependent: :destroy

  def add_destination(choice_content, destination_content)
    destination = Place.create(game: game, content: destination_content)
    choice = Choice.create(game: self.game, source: self,
                           target: destination, content: choice_content)
    [choice, destination]
  end

  def dead_end?
    choices.empty?
  end

  def editable?(user)
    game.editable?(user)
  end
end
