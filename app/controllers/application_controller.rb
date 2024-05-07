class ApplicationController < ActionController::Base
  include Clearance::Controller

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  # Token-based authentication based on suggestions from
  # https://github.com/thoughtbot/clearance/wiki/API-Authentication

  def require_login_via_token
    authenticate_via_token

    unless signed_in?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def authenticate_via_token
    logger.info "TOKEN: #{api_token}"

    return unless api_token
    user = User.find_by(api_token: api_token)
    sign_in user if user
    cookies.delete :remember_token
  end

  private

  def api_token
    pattern = /^Bearer /
    header  = request.env["HTTP_AUTHORIZATION"]
    header.gsub(pattern, "") if header && header.match(pattern)
  end
end
