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
end
