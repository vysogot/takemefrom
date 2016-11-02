class Game < ApplicationRecord
  has_one :beginning, class_name: "Place"
  has_many :places
  belongs_to :user
end
