FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Delicious recipe #{n}" }
    description { "A great-tasting dish!" }
    association :category
    association :user

    trait :invalid do
      name { nil }
    end
  end
end
