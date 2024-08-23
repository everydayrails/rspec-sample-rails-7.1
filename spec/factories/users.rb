FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password { "password" }
  end
end
