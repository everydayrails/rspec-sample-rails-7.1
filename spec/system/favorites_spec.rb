require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    user = FactoryBot.create(:user)

    visit sign_in_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  it "sets and unsets a favorite recipe" do
    recipe = FactoryBot.create(:recipe)

    visit recipe_path(recipe)

    expect(page).to_not have_content "un-favorite"

    within "#favorite_button" do
      click_on "favorite"
    end

    within "#favorite_button" do
      click_on "un-favorite"
    end

    expect(page).to have_button "favorite"
    expect(page).to_not have_content "un-favorite"
  end
end
