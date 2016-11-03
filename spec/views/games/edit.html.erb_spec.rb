require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :name => "MyString",
      :slug => "MyString",
      :user_id => "MyString",
      :beginning_id => "MyString"
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input#game_name[name=?]", "game[name]"

      assert_select "input#game_slug[name=?]", "game[slug]"

      assert_select "input#game_user_id[name=?]", "game[user_id]"

      assert_select "input#game_beginning_id[name=?]", "game[beginning_id]"
    end
  end
end
