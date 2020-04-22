FactoryBot.define do
  factory :notification, class: Notification::Notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    association :notifiable, factory: :function
    type { 'Notification::Liked' }
    read_at { nil }
  end
end
