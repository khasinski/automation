class Api::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_from_token!
  before_action :ensure_params_exist

  def create
    user = User.find_for_database_authentication(email: sign_in_params[:email])
    return invalid_login_attempt unless user
    return invalid_login_attempt unless user.valid_password?(sign_in_params[:password])
    auth_token = ::JsonWebToken.encode(user_email: user.email)
    bearer_token = "Bearer #{auth_token}"
    user.update_attribute(:authentication_token, auth_token)
    response.set_header("Authorization", bearer_token)
    render json: {}, status: 200
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_params_exist
    if params[:user].blank? || sign_in_params[:email].blank? || sign_in_params[:password].blank?
      return render_unauthorized errors: { unauthenticated: ["Incomplete credentials"] }
    end
  end

  def invalid_login_attempt
    render_unauthorized errors: { unauthenticated: ["Invalid credentials"] }
  end
end
