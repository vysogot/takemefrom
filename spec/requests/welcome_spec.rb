require 'rails_helper'

RSpec.describe "landing page", :type => :request do

  before do
    @user = FactoryGirl.create(:user)
    @game = FactoryGirl.create(:game, name: "Simple game")
  end

  it "shows right links to a guest" do
    visit "/"
    assert has_link? "Play", href: place_path(@game)
    assert has_link? "Redesign", href: game_path(@game)
    assert has_link? "Browse", href: games_path
    assert has_link? "Create", href: new_game_path
    assert has_link? "Log in", href: new_user_session_path
    assert has_no_link? "Log out", href: destroy_user_session_path
    assert has_link? "Contribute", href: 'http://github.com/vysogot/takemefrom'
  end

  it "shows right links to a logged in user" do
    sign_in @user

    visit "/"
    assert has_link? "Play", href: place_path(@game)
    assert has_link? "Redesign", href: game_path(@game)
    assert has_link? "Browse", href: games_path
    assert has_link? "Create", href: new_game_path
    assert has_no_link? "Log in", href: new_user_session_path
    assert has_link? "Log out", href: destroy_user_session_path
    assert has_link? "Contribute", href: 'http://github.com/vysogot/takemefrom'
  end
end
