FactoryBot.define do
  factory :function do
    usage { Faker::Lorem.paragraph }
    sequence(:code) { |n| "def foo#{n}; end" }
    association :user

    trait :invalid_name do
      sequence(:code) { |n| "def #{n}foo; end" }
    end

    after(:build) do |function|
      function.send(:extract_function_name)
    rescue SyntaxError
      nil
    end
  end
end
