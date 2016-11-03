FactoryGirl.define do
  factory :action do
    game
    source factory: :place
    target factory: :place
    sequence(:content) { |i| "Action content #{i}" }
  end
end
