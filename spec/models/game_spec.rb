require 'rails_helper'

RSpec.describe Game, type: :model do
  it "has a beginning" do
    game = FactoryGirl.create(:game)
    place = Place.first
    expect(game.beginning).to be_a(Place)
    expect(game.beginning).to eq(place)
  end

  it "can be edited by the owner" do
    game = FactoryGirl.create(:game)
    other_user = FactoryGirl.create(:user)

    expect(game.editable?(game.user)).to be_truthy
    expect(game.editable?(other_user)).to be_falsy
  end
end
