class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @recipes = current_user.recipes
  end

  def favorites
    @recipes = current_user.favorites
  end
end
