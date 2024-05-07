class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    render :index, format: :json
  end

  def show
    @recipe = Recipe.find(params[:id])

    render :show, format: :json
  end
end
