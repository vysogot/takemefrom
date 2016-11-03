json.extract! game, :id, :name, :slug, :user_id, :beginning_id, :created_at, :updated_at
json.url game_url(game, format: :json)