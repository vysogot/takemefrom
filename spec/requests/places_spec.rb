require 'rails_helper'

RSpec.describe "Places", type: :request do
  describe "shows place" do
    it "displays choice links" do
      choice1 = FactoryGirl.create(:choice)
      choice2 = FactoryGirl.create(:choice, source: choice1.source)

      visit place_path(choice1.source)

      expect has_link? choice1.content
      expect has_link? choice2.content
    end
  end
end
