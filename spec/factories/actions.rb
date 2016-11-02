FactoryGirl.define do
  factory :action do
    game
    source factory: :place
    target factory: :place
    content "MyString"
  end
end
