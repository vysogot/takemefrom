# json.extract! place, :id, :content, :game_id, :created_at, :updated_at
# json.url place_url(place, format: :json)

json.newNode do
  json.id @place.id
  json.content @place.content
end

json.newEdge do
  json.source @origin.id
  json.target @place.id
  json.content @choice.content
  json.edgeId @choice.id
end
