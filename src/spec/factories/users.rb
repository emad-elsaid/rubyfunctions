FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.unique.username(separators: '-') }
    sequence(:github_id)
  end
end
