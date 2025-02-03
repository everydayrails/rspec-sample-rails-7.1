require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with a user, recipe, and comment" do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.create(:recipe)
    comment = Comment.new(
      user: user,
      recipe: recipe,
      comment: "This is a comment."
    )
    expect(comment).to be_valid
  end

  it "requires a comment to have at least one character" do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.create(:recipe)
    comment = Comment.new(
      user: user,
      recipe: recipe,
      comment: ""
    )
    expect(comment).to_not be_valid
    expect(comment.errors.messages[:comment]).to include "is too short (minimum is 1 character)"
  end

  it "prohibits lengthy comments" do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.create(:recipe)
    comment = Comment.new(
      user: user,
      recipe: recipe,
      comment: "a" * 1001
    )
    expect(comment).to_not be_valid
    expect(comment.errors.messages[:comment]).to include "is too long (maximum is 1000 characters)"
  end
end
