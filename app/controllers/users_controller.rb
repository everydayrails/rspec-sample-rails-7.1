class UsersController < Clearance::UsersController
  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    nickname = user_params.delete(:nickname)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    # params[Clearance.configuration.user_parameter] || {}
    params.require(:user).permit(:email, :password, :nickname)
  end
end
