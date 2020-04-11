FactoryBot.define do
  factory :follow do
    association :follower
    association :following
  end
end
