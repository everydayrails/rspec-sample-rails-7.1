class RecipeMailer < ApplicationMailer
  default from: "recipes@example.com"

  def recent
    @user = params[:user]
    date = params[:date]
    @recipes = Recipe.where("created_at >= ?", date)

    mail(to: @user.email, subject: "Recent new recipes")
  end
end
