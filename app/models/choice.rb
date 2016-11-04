class Choice < ApplicationRecord
  belongs_to :game
  belongs_to :source,
    class_name: "Place", foreign_key: "source_id"

  belongs_to :target,
    class_name: "Place", foreign_key: "target_id"
end
