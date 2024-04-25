class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @recipes = current_user.recipes
    render "recipes/index"
  end
end
