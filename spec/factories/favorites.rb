FactoryBot.define do
  factory :favorite do
    association :user
    association :recipe
  end
end
