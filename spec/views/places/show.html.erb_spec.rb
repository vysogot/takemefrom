require 'rails_helper'

RSpec.describe "places/show", type: :view do
  before(:each) do
    @place = assign(:place, Place.create!(
      :content => "Content",
      :game_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(//)
  end
end
