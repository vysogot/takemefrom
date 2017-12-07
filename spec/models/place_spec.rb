require 'rails_helper'

RSpec.describe Place, type: :model do
  it "adds destination" do
    game = FactoryBot.create(:game)
    game.beginning.add_destination("You turn left", "Labirynth")

    expect(game.places.count).to eq(2)
    expect(game.beginning.choices.count).to eq(1)
  end

  it "is a dead end when no choices can be made" do
    place = FactoryBot.create(:place)
    expect(place.choices.count).to eq(0)
    expect(place.dead_end?).to be_truthy
  end

  it "can be edited by the game owner" do
    place = FactoryBot.create(:place)
    other_user = FactoryBot.create(:user)

    expect(place.editable?(place.game.user)).to be_truthy
    expect(place.editable?(other_user)).to be_falsy
  end
end
