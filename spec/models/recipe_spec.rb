require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it "does not allow duplicate recipe names per user" do
    user = User.create(
      nickname: "test-user",
      email:      "test-user@example.com",
      password:   "password"
    )

    category = Category.create(name: "Test Category")

    user.recipes.create(
      name: "Test Recipe",
      category: category
    )

    second_recipe = user.recipes.build(
      name: "Test Recipe",
    )

    expect(second_recipe).to_not be_valid
    expect(second_recipe.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    user = User.create(
      nickname: "test-user",
      email:      "test-user@example.com",
      password:   "password"
    )

    other_user = User.create(
      nickname: "another-test-user",
      email:      "another-test-user@example.com",
      password:   "password"
    )

    category = Category.create(name: "Test Category")

    user.recipes.create(
      name: "Test Recipe",
      category: category
    )

    second_recipe = other_user.recipes.build(
      name: "Test Recipe",
      category: category
    )

    expect(second_recipe).to be_valid
  end

  it "finds recipes that contain the search term in their name" do
    user = User.create(
      nickname: "test-user",
      email: "test-user@example.com",
      password: "password"
    )

    category = Category.create(name: "Test Category")

    first_recipe = user.recipes.create(
      name: "Pepperoni Pizza",
      category: category
    )

    second_recipe = user.recipes.create(
      name: "Cheese Pizza",
      category: category
    )

    results = Recipe.by_word_in_name("pepperoni")

    expect(results).to include(first_recipe)
    expect(results).to_not include(second_recipe)
  end

  it "returns an empty collection when no recipes matching the search term are found" do
    user = User.create(
      nickname: "test-user",
      email: "test-user@example.com",
      password: "password"
    )

    category = Category.create(name: "Test Category")

    first_recipe = user.recipes.create(
      name: "Pepperoni Pizza",
      category: category
    )

    second_recipe = user.recipes.create(
      name: "Cheese Pizza",
      category: category
    )

    results = Recipe.by_word_in_name("veggie")

    expect(results).to be_empty
  end
end
