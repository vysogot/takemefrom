require 'rails_helper'

RSpec.describe Game, type: :model do
  it "has a beginning" do
    game = FactoryGirl.create(:game)
    place = Place.first
    expect(game.beginning).to be_a(Place)
    expect(game.beginning).to eq(place)
  end
end
