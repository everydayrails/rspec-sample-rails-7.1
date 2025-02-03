require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }

  it "does not allow duplicate recipe names per user" do
    FactoryBot.create(:recipe, user: user, name: "Test Recipe")

    second_recipe = user.recipes.build(
      name: "Test Recipe",
    )

    expect(second_recipe).to_not be_valid
    expect(second_recipe.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a recipe name" do
    FactoryBot.create(:recipe, user: user, name: "Test Recipe")

    second_recipe = other_user.recipes.build(
      name: "Test Recipe",
      category: category
    )

    expect(second_recipe).to be_valid
  end

  describe "scope by_word_in_name" do
    let!(:first_recipe) { user.recipes.create(name: "Pepperoni Pizza", category: category) }
    let!(:second_recipe) { user.recipes.create(name: "Cheese Pizza", category: category) }

    context "when a match is found" do
      it "returns matching recipes" do
        results = Recipe.by_word_in_name("pepperoni")

        expect(results.pluck(:name)).to include "Pepperoni Pizza"
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        results = Recipe.by_word_in_name("veggie")

        expect(results).to be_empty
      end
    end
  end
end
