require 'rails_helper'

RSpec.describe "places/edit", type: :view do
  before(:each) do
    @place = assign(:place, Place.create!(
      :content => "MyString",
      :game_id => ""
    ))
  end

  it "renders the edit place form" do
    render

    assert_select "form[action=?][method=?]", place_path(@place), "post" do

      assert_select "input#place_content[name=?]", "place[content]"

      assert_select "input#place_game_id[name=?]", "place[game_id]"
    end
  end
end
