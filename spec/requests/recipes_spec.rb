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
end
