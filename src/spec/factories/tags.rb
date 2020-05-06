FactoryBot.define do
  factory :tag do
    name { Faker::Hacker.adjective.gsub(' ', '-') }
  end
end
