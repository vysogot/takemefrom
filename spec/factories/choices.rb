FactoryGirl.define do
  factory :choice do
    game
    source factory: :place
    target factory: :place
    sequence(:content) { |i| "Choice content #{i}" }
  end
end
