class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_recipe

  # POST /favorites or /favorites.json
  def create
    @favorite = current_user.favorites.new(recipe: @recipe)

    respond_to do |format|
      if @favorite.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite_button", partial: "recipes/destroy_favorite_button", locals: { recipe: @recipe, favorite: @favorite }) }
        format.html { redirect_to @recipe, notice: "Favorite was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite_button", partial: "recipes/new_favorite_button", locals: { recipe: @recipe, favorite: @favorite }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite_button", partial: "recipes/new_favorite_button", locals: { recipe: @recipe, favorite: @favorite }) }
      format.html { redirect_to @recipe, notice: "Favorite was successfully destroyed." }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def favorite_params
    params.require(:favorite).permit(:recipe_id)
  end
end
