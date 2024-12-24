FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Delicious recipe #{n}" }
    description { "A great-tasting dish!" }
    ingredients { "1 cup of sugar" }
    instructions { "Mix the ingredients together" }
    association :category
    association :user
  end
end
