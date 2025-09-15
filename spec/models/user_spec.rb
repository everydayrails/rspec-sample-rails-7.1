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

  describe "API token generation" do
    it "sets a new user's unique API token" do
      user = FactoryBot.build(:user, api_token: nil)
      allow(SecureRandom).to receive(:uuid).and_return("abc123")
      allow(User).to receive(:find_by).with(api_token: "abc123").and_return(nil)

      user.save

      expect(user.api_token).to eq("abc123")
    end

    it "tries another API token if the first one is taken" do
      existing_user = instance_double(User)

      allow(SecureRandom).to receive(:uuid).and_return("abc123", "def456")
      allow(User).to receive(:find_by).with(api_token: "abc123").and_return(existing_user)
      allow(User).to receive(:find_by).with(api_token: "def456").and_return(nil)

      user2 = FactoryBot.build(:user, api_token: nil)
      user2.save

      expect(user2.api_token).to eq("def456")
    end
  end

  it "indicates a new user" do
    user = FactoryBot.build(:user, created_at: Time.now)

    expect(user).to be_new_to_site
  end

  it "indicates an established user" do
    user = User.new(created_at: 1.month.ago)

    expect(user).to_not be_new_to_site
  end

  it "sets an avatar" do
    user = User.new(
      email: "test@example.com",
      password: "password",
      nickname: "test_user"
    )

    mock_io = StringIO.new("fake image data")
    allow(URI).to receive(:open)
      .with("https://api.dicebear.com/8.x/thumbs/png?seed=test_user")
      .and_return(mock_io)
    allow(user.avatar).to receive(:attach).and_call_original

    user.save

    expect(URI).to \
      have_received(:open).with("https://api.dicebear.com/8.x/thumbs/png?seed=test_user")
    expect(user.avatar).to have_received(:attach).with(
      io: mock_io,
      filename: "avatar.png",
      content_type: "image/png"
    )
  end
end
