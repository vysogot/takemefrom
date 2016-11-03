require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :name => "Name",
      :slug => "Slug",
      :user_id => "User",
      :beginning_id => "Beginning"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/User/)
    expect(rendered).to match(/Beginning/)
  end
end
