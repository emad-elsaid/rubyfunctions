FactoryBot.define do
  factory :like do
    association :likeable, factory: :function
    association :user
  end
end
