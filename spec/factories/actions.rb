FactoryGirl.define do
  factory :action do
    source factory: :place
    target factory: :place
    sequence(:content) { |i| "Action content #{i}" }
  end
end
