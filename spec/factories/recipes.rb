FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Delicious recipe #{n}" }
    description { "A great-tasting dish!" }
    association :category
    association :user
  end
end
