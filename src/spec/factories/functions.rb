FactoryBot.define do
  factory :function do
    name { Faker::Alphanumeric.alphanumeric(number: 10) }
    usage  { Faker::Lorem.paragraph }
    code { Faker::Lorem.paragraph }
    association :user

    trait :invalid_name do
      name { nil }
    end
  end
end
