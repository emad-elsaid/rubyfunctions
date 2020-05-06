FactoryBot.define do
  factory :function do
    usage { Faker::Lorem.paragraph }
    sequence(:code) { |n| "def foo#{n}; end" }
    association :user

    tags { |tag| [tag.association(:tag)] }

    trait :invalid_name do
      sequence(:code) { |n| "def #{n}foo; end" }
    end

    after(:build) do |function|
      function.name = Code.new(function.code).functions.first
    end
  end
end
