require 'rails_helper'

RSpec.describe Choice, type: :model do
  it "gets destroyed along with its source" do
    choice = FactoryGirl.create(:choice)
    choice.source.destroy!
    expect(Choice.first).to be_nil
  end
end
