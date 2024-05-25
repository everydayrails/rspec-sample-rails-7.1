require 'rails_helper'

RSpec.describe User, type: :model do
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
    user = User.new(nickname: nil)

    expect(user).to be_invalid
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  it "requires a unique nickname"
  it "requires an email"
  it "requires a unique email"
  it "requires a password"
  it "requires an API token"
  it "sets a new user's API token"
end
