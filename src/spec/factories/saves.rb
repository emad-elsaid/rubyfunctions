FactoryBot.define do
  factory :save do
    association :user
    association :function
  end
end
