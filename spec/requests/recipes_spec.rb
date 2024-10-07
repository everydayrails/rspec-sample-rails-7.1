require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    context "as a guest" do
      it "redirects to sign-in" do
        get recipes_path

        expect(response).to redirect_to sign_in_path
      end
    end

    context "as an authenticated user" do
      it "displays recipes list to authenticated user" do
        get recipes_path(as: FactoryBot.create(:user))

        expect(response).to have_http_status(:ok) # or be_successful
      end
    end
  end

  describe "POST /create" do
    context "as a guest" do
      it "redirects to sign-in" do
        recipe_attributes = FactoryBot.attributes_for(:recipe,
          category_id: FactoryBot.create(:category).id
        )

        post recipes_path params: { recipe: recipe_attributes }

        expect(response).to redirect_to sign_in_path
      end
    end

    context "as an authenticated user" do
      it "redirects to the user's new recipe" do
        user = FactoryBot.create(:user)
        recipe_attributes = FactoryBot.attributes_for(:recipe,
          category_id: FactoryBot.create(:category).id
        )

        post recipes_path(as: user),
          params: { recipe: recipe_attributes }

        expect(response).to redirect_to recipe_path(user.recipes.last)
      end
    end
  end

  describe "GET /edit" do
    context "as a guest" do
      it "redirects to sign-in" do
        recipe = FactoryBot.create(:recipe)

        get edit_recipe_path(recipe)

        expect(response).to redirect_to sign_in_path
      end
    end

    context "as the owner of this recipe" do
      it "displays recipe edit form" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, user: user)

        get edit_recipe_path(recipe, as: user)

        expect(response).to be_successful
      end
    end

    context "as a user who is not the owner of this recipe" do
      it "returns a 404" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe)

        get edit_recipe_path(recipe, as: user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /update" do
    context "as a guest" do
      it "redirects to sign-in" do
        recipe = FactoryBot.create(:recipe, name: "Old name")
        recipe_attributes = FactoryBot.attributes_for(:recipe,
          name: "New name",
          category_id: FactoryBot.create(:category).id
        )

        patch recipe_path(recipe),
          params: { recipe: recipe_attributes }

        expect(response).to redirect_to sign_in_path
        expect(recipe.reload.name).to eq "Old name"
      end
    end

    context "as the owner of this recipe" do
      it "updates the recipe" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, user: user, name: "Old name")
        recipe_attributes = FactoryBot.attributes_for(:recipe,
          name: "New name",
          category_id: FactoryBot.create(:category).id
        )

        patch recipe_path(recipe, as: user),
          params: { recipe: recipe_attributes }

        expect(response).to redirect_to recipe_path(recipe)
        expect(recipe.reload.name).to eq "New name"
      end
    end

    context "as a user who is not the owner of this recipe" do
      it "does not update the recipe" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, name: "Old name")
        recipe_attributes = FactoryBot.attributes_for(:recipe,
          name: "New name",
          category_id: FactoryBot.create(:category).id
        )

        patch recipe_path(recipe, as: user),
          params: { recipe: recipe_attributes }

        expect(response).to have_http_status(:not_found)
        expect(recipe.reload.name).to eq "Old name"
      end
    end
  end

  describe "DELETE /destroy" do
    context "as a guest" do
      it "redirects to sign-in" do
        recipe = FactoryBot.create(:recipe)

        expect {
          delete recipe_path(recipe)
        }.to_not change(Recipe, :count)

        expect(response).to redirect_to sign_in_path
      end
    end

    context "as the owner of this recipe" do
      it "deletes the recipe" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe, user: user)

        expect {
          delete recipe_path(recipe, as: user)
        }.to change(user.recipes, :count).by(-1)

        expect(response).to redirect_to recipes_path
      end
    end

    context "as a user who is not the owner of this recipe" do
      it "does not delete the recipe" do
        user = FactoryBot.create(:user)
        recipe = FactoryBot.create(:recipe)

        expect {
          delete recipe_path(recipe, as: user)
        }.to_not change(Recipe, :count)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
