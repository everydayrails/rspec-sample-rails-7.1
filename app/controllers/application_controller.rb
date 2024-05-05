class ApplicationController < ActionController::Base
  include Clearance::Controller

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
