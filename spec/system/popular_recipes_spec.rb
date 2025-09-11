require 'rails_helper'

RSpec.describe "Popular recipes", type: :system do

  let(:user) { FactoryBot.create(:user) }

  let!(:recipe1) { FactoryBot.create(:recipe, name: "Mildly interesting recipe") }
  let!(:recipe2) { FactoryBot.create(:recipe, name: "Boring recipe") }
  let!(:recipe3) { FactoryBot.create(:recipe, name: "Exciting recipe") }

  before do
    driven_by(:rack_test)
  end

  it "displays a list of popular recipes" do
    3.times { FactoryBot.create(:favorite, recipe: recipe3) }
    2.times { FactoryBot.create(:favorite, recipe: recipe1) }

    sign_in_as(user)

    visit root_path
    click_link "Popular"

    expect(page).to have_current_path "/recipes/popular"

    expect(page).to have_content "Popular recipes"

    expect(page).to have_content "Exciting recipe"
    expect(page).to have_content "Mildly interesting recipe"
    expect(page).to have_content "Boring recipe"
  end
end
