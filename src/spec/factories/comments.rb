FactoryBot.define do
  factory :comment do
    association :user
    association :function
    content { Faker::Lorem.paragraph }
  end
end
