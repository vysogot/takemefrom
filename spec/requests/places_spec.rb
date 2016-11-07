require 'rails_helper'

RSpec.describe "Places", type: :request do
  describe "shows place" do
    it "displays choice links" do
      choice1 = FactoryGirl.create(:choice)
      choice2 = FactoryGirl.create(:choice, source: choice1.source)

      visit place_path(choice1.source)

      assert has_link? choice1.content
      assert has_link? choice2.content
    end
  end

  describe "shows redesign link properly" do
    before do
      @user = FactoryGirl.create(:user)
      @game = FactoryGirl.create(:game, user: @user)
    end

    it "displays redesign link to the owner" do
      sign_in @user
      visit place_path(@game.beginning)
      assert has_link? "Redesign this place", href: edit_game_path(@game)
    end

    it "does not display redesign link to not owner" do
      visit place_path(@game.beginning)
      assert has_no_link? "Redesign this place", href: edit_game_path(@game)
    end
  end
end
