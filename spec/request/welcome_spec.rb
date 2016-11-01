require 'rails_helper'

RSpec.describe "landing page", :type => :request do
  it "shows right links to a guest" do
    visit "/"
    assert has_link? "Play"
    assert has_link? "Redesign"
    assert has_link? "Browse"
    assert has_link? "Create"
    assert has_link? "Log in"
    assert has_no_link? "Log out"
    assert has_link? "Contribute"
  end

  it "shows right links to a logged in user" do
    sign_in FactoryGirl.create(:user)
    visit "/"
    assert has_link? "Play"
    assert has_link? "Redesign"
    assert has_link? "Browse"
    assert has_link? "Create"
    assert has_no_link? "Log in"
    assert has_link? "Log out"
    assert has_link? "Contribute"
  end
end
