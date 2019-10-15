# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :choice do
    game
    source factory: :place
    target factory: :place
    sequence(:content) { |i| "Choice content #{i}" }
  end

  factory :game do
    user
    name { 'MyString' }
    slug { 'MyString' }
  end

  factory :place, aliases: [:beginning] do
    game
    sequence(:content) { |i| "Place #{i} content" }
  end

  factory :user do
    email
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
