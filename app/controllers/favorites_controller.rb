class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_recipe

  # POST /favorites or /favorites.json
  def create
    @favorite = current_user.favorites.new(recipe: @recipe)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @recipe, notice: "Favorite was successfully created." }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "Favorite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:recipe_id)
    end
end
