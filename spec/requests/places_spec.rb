require 'rails_helper'

RSpec.describe "Places", type: :request do
  describe "shows place" do
    it "displays action links" do
      action1 = FactoryGirl.create(:action)
      action2 = FactoryGirl.create(:action, source: action1.source)

      visit place_path(action1.source)

      expect has_link? action1.content
      expect has_link? action2.content
    end
  end
end
