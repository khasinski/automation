class Api::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def create
    user = User.new(sign_up_params)
    user.authentication_token = ::JsonWebToken.encode(user_email: user.email)
    user.authentication_token_created_at = Time.now
    if user.save
      response.set_header('Authorization-Token', user.authentication_token)
      render :json => user.as_json(:email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :provider, :uid, :name)
  end

end
