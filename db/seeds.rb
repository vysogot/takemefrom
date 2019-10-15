# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by(email: "admin@takemefrom.com") do |u|
  u.password = "foobar"
  u.password_confirmation = "foobar"
end

game = Game.create!(name: "Simple game", user: user)
game.beginning.add_destination("Turn left", "You are in the temple")
game.beginning.add_destination("Turn right", "You are in the cowshed")
game.update(elements: game.to_elements)
