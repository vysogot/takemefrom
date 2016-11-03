FactoryGirl.define do
  factory :place, aliases: [:beginning] do
    game
    sequence(:content) { |i| "Place #{i} content" }
  end
end
