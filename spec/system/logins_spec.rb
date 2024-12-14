require 'rails_helper'

RSpec.describe "Logins", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "logs the user in and out" do
    user = FactoryBot.create(:user,
      email: "test@example.com",
      password: "password123",
      nickname: "testuser"
    )

    visit root_path

    expect(page).to_not have_content "Sign out"
    expect(page).to_not have_content "testuser"

    within ".navbar" do
      click_link "Sign in"
    end

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Sign in"

    within ".navbar" do
      expect(page).to have_button "Sign out"
      expect(page).to_not have_link "Sign in"
      expect(page).to have_content "testuser"
      expect(page).to have_link "My recipes", href: profile_path
    end

    click_button "Sign out"

    expect(page).to_not have_content "Sign out"
    expect(page).to_not have_content "testuser"

    within ".navbar" do
      expect(page).to have_link "Sign in"
    end
  end
end
