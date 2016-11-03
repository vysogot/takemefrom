class Game < ApplicationRecord
  has_one :beginning, class_name: "Place"
  has_many :places
  belongs_to :user

  after_create :create_beginning

  def create_beginning
    Place.create(game: self, content: "The beginning of #{name}...")
  end
end
