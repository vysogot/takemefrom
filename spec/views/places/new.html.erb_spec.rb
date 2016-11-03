require 'rails_helper'

RSpec.describe "places/new", type: :view do
  before(:each) do
    assign(:place, Place.new(
      :content => "MyString",
      :game_id => ""
    ))
  end

  it "renders new place form" do
    render

    assert_select "form[action=?][method=?]", places_path, "post" do

      assert_select "input#place_content[name=?]", "place[content]"

      assert_select "input#place_game_id[name=?]", "place[game_id]"
    end
  end
end
