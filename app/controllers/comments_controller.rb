class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_recipe

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.new(comment_params.merge(recipe: @recipe))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @recipe, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render @recipe, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

# Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
