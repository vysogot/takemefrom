require 'rails_helper'

RSpec.describe Place, type: :model do
  it "adds destination" do
    game = FactoryGirl.create(:game)
    game.beginning.add_destination("You turn left", "Labirynth")

    expect(game.places.count).to eq(2)
    expect(game.beginning.choices.count).to eq(1)
  end
end
