require 'rails_helper'

RSpec.describe Place, type: :model do
  it "adds destination" do
    game = FactoryGirl.create(:game)
    place = game.beginning
    place.create_destination("You turn left", "Labirynth")
    expect(place.game.places.count).to eq(2)
    expect(place.actions.count).to eq(1)
  end
end
