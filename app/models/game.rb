class Game < ApplicationRecord
  has_one :beginning, class_name: "Place"
  has_many :places
  has_many :choices
  belongs_to :user

  after_create :create_beginning

  def create_beginning
    create_beginning!(content: "The beginning of #{name}...")
  end

  def editable?(user)
    user && user.id == user_id
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

  def choices_for_graph
    new_edges = []
    choices.as_json(only:
      [:id, :source_id, :target_id, :content]).each do |entry|
        new_edges << { data: {
          "id" => "edge-#{entry["id"]}",
          "source" => entry["source_id"].to_s,
          "target" => entry["target_id"].to_s,
          "content" => entry["content"].to_s
        } }
      end
    new_edges
  end

  def touched?
    created_at != updated_at
  end

  def to_elements
    places_for_graph + choices_for_graph
  end
end
