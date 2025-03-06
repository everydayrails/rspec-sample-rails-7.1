require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:category, name: "Dessert") }

  it "adds a recipe" do
    sign_in_as(user)

    click_link "New recipe"

    fill_in "Name", with: "Apple pie"
    select "Dessert", from: "Category"
    fill_in "Description", with: "A delicious pie made with apples"
    fill_in "Ingredients", with: "- 1 cup of flour\n- 1 cup of sugar\n- 1 cup of apples"
    fill_in "Instructions", with: "1. Mix the ingredients\n2. Bake at 350 degrees for 30 minutes"
    click_button "Create Recipe"

    aggregate_failures do
      expect(page).to have_content "Recipe was successfully created."
      expect(page).to have_content "Apple pie"
      expect(page).to have_content "Dessert"
      expect(page).to have_content "A delicious pie made with apples"
      expect(page).to have_content "1 cup of flour 1 cup of sugar 1 cup of apples"
      expect(page).to have_content "Mix the ingredients Bake at 350 degrees for 30 minutes"
      expect(page).to have_content "Shared by #{user.nickname}"
    end
  end
end
