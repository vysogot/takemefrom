require 'rails_helper'

RSpec.describe Action, type: :model do
  it "gets destroyed along with its source" do
    action = FactoryGirl.create(:action)
    source = action.source
    source.destroy!
    expect(Action.first).to be_nil
  end
end
