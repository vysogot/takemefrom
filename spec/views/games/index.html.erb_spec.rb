require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        :name => "Name",
        :slug => "Slug",
        :user_id => "User",
        :beginning_id => "Beginning"
      ),
      Game.create!(
        :name => "Name",
        :slug => "Slug",
        :user_id => "User",
        :beginning_id => "Beginning"
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Beginning".to_s, :count => 2
  end
end
