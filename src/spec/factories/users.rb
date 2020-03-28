FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username }
    github_id { 'u' + rand(10_000..999_999).to_s }
  end
end
