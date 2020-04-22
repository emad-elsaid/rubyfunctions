FactoryBot.define do
  factory :notification, class: Notification::Notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    type { 'Liked' }
    read_at { nil }
  end
end
