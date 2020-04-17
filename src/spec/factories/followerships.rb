FactoryBot.define do
  factory :followership do
    association :follower, factory: :user
    association :followee, factory: :user
  end
end
