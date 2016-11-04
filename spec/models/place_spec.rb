require 'rails_helper'

RSpec.describe Place, type: :model do
  it "adds destination" do
    game = FactoryGirl.create(:game)
    game.beginning.add_destination("You turn left", "Labirynth")

    expect(game.places.count).to eq(2)
    expect(game.beginning.choices.count).to eq(1)
  end

  it "is a dead end when no choices can be made" do
    place = FactoryGirl.create(:place)
    expect(place.choices.count).to eq(0)
    expect(place.dead_end?).to be_truthy
  end
end
