# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landing page', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @game = FactoryBot.create(:game, name: 'Tutorial')
  end

  it 'shows right links to a guest' do
    visit '/'

    assert has_link? 'Play', href: game_path(@game)
    assert has_no_link? 'Your games', href: games_path
    assert has_link? 'Log in', href: new_user_session_path
    assert has_no_link? 'Log out', href: destroy_user_session_path
  end

  it 'shows right links to a logged in user' do
    sign_in @user

    visit '/'
    assert has_link? 'Play', href: game_path(@game)
    assert has_link? 'Browse', href: games_path
    assert has_no_link? 'Log in', href: new_user_session_path
    assert has_link? 'Log out', href: destroy_user_session_path
  end
end
