require 'rails_helper'

RSpec.describe "Comments", type: :request do
  include_context "recipe setup"

  describe "POST /create" do
    context "as a guest" do
      it "adds no comments and redirects to login" do
        expect {
          post recipe_comments_path :recipe,
            params: { comment: { comment: "Test comment" } }
        }.to_not change(Comment, :count)

        expect(response).to require_login
      end
    end

    context "as an authenticated user" do
      it "adds a valid comment and redirects to the recipe" do
        expect {
          post recipe_comments_path recipe, as: user,
            params: { comment: { comment: "Test comment" } }
        }.to change(recipe.comments, :count).by(1)

        expect(response).to redirect_to recipe_path(recipe)
      end

      it "fails to create a comment with invalid attributes" do
        expect {
          post recipe_comments_path recipe, as: user,
            params: { comment: { comment: nil } }
        }.to_not change(recipe.comments, :count)
        expect(response).to be_unprocessable
      end
    end
  end
end
