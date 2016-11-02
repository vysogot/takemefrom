FactoryGirl.define do
  factory :game do
    user
    name "MyString"
    slug "MyString"
    after(:create) do |game|
      create :beginning, game: game
    end
  end
end
