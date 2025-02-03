require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:comment) { FactoryBot.build(:comment, user: user, recipe: recipe) }

  it "is valid with a user, recipe, and comment" do
    comment.comment = "This is a comment."
    expect(comment).to be_valid
  end

  it "requires a comment to have at least one character" do
    comment.comment = ""
    expect(comment).to_not be_valid
    expect(comment.errors.messages[:comment]).to include "is too short (minimum is 1 character)"
  end

  it "prohibits lengthy comments" do
    comment.comment = "a" * 1001
    expect(comment).to_not be_valid
    expect(comment.errors.messages[:comment]).to include "is too long (maximum is 1000 characters)"
  end
end
