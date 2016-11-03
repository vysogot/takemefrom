class Game < ApplicationRecord
  has_one :beginning, class_name: "Place"
  has_many :places
  has_many :actions
  belongs_to :user

  after_create :create_beginning

  def create_beginning
    Place.create(game: self, content: "The beginning of #{name}...")
  end

  def places_for_graph
    new_nodes = []
    places.as_json(only:
      [:id, :content]).each do |entry|
        new_nodes << { data: {
          "id" => entry["id"].to_s,
          "content" => entry["content"].to_s
        } }
      end
    new_nodes
  end

  def actions_for_graph
    new_edges = []
    actions.as_json(only:
      [:id, :source_id, :target_id, :content]).each do |entry|
        new_edges << { data: {
          "edgeId" => entry["id"].to_s,
          "source" => entry["source_id"].to_s,
          "target" => entry["target_id"].to_s,
          "content" => entry["content"].to_s
        } }
      end
    new_edges
  end
end
