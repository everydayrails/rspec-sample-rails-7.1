require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with an email, password, nickname, and API token" do
    user = User.new(
      email: "test@example.com",
      password: "password",
      nickname: "test",
      api_token: "token"
    )

    expect(user).to be_valid
  end

  it "requires a nickname" do
    user = FactoryBot.build(:user, nickname: nil)

    expect(user).to be_invalid
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  it "requires a unique nickname" do
    FactoryBot.create(:user, nickname: "test")
    user = FactoryBot.build(:user, nickname: "test")

    expect(user).to be_invalid
    expect(user.errors[:nickname]).to include("has already been taken")
  end

  it "requires an email" do
    user = FactoryBot.build(:user, email: nil)

    expect(user).to be_invalid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "requires a unique email"
  it "requires a password"
  it "requires an API token"
  it "sets a new user's API token"

  it "indicates a new user" do
    user = User.new(created_at: Time.now)

    expect(user).to be_new_to_site
  end

  it "indicates an established user" do
    user = User.new(created_at: 1.month.ago)

    expect(user).to_not be_new_to_site
  end
end
