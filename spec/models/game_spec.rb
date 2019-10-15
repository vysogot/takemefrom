# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'can be edited by the owner' do
    game = FactoryBot.create(:game)
    other_user = FactoryBot.create(:user)

    expect(game.editable?(game.user)).to be_truthy
    expect(game.editable?(other_user)).to be_falsy
  end
end
