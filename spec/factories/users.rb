FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password { "password" }

    after(:build) do |user|
      # Avoid hitting the Dicebear API when generating test users
      def user.set_avatar
        self.avatar.attach(
          io: File.open(Rails.root.join("spec", "fixtures", "avatar.png")),
          filename: "avatar.png",
          content_type: "image/png"
        )
      end
    end
  end
end
