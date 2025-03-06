require "rails_helper"

RSpec.describe "Api::Recipes", type: :request do
  describe "GET /index" do
    context "as a guest" do
      it "redirects to sign-in" do
        get api_recipes_path, as: :json

        expect(response).to be_unauthorized
      end
    end

    context "as an authenticated user" do
      it "displays recipes list to authenticated user" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, name: "Spaghetti")

        get api_recipes_path, headers: {
          "Authorization" => "Bearer #{user.api_token}"
        }, as: :json

        expect(response).to be_successful

        body = JSON.parse(response.body)
        expect(body.length).to eq 1
        expect(body.first).to include(
          "name" => "Spaghetti",
          "id" => recipe.id
        )
      end
    end
  end

  describe "GET /show" do
    context "as an authenticated user" do
      it "returns requested recipe" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, name: "Spaghetti")
        other_recipe = FactoryBot.create(:recipe, name: "Lasagna")

        get api_recipe_path(recipe), headers: {
          "Authorization" => "Bearer #{user.api_token}"
        }, as: :json

        expect(response).to be_successful

        body = JSON.parse(response.body)
        aggregate_failures do
          expect(body).to include(
            "name" => "Spaghetti",
            "id" => recipe.id
          )
          expect(body).to_not include(
            "name" => "Lasagna",
            "id" => other_recipe.id
          )
        end
      end
    end
  end
end
