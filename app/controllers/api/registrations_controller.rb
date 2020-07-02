# frozen_string_literal: true

class Api::RegistrationsController < Api::BaseController
  skip_before_action :authenticate_user_from_token!
  def create
    create_user = CreateUser.new
    create_user.subscribe(::UserNotifier.new)
    create_user.on(:create_user_success) do |user|
      response.set_header('Authorization-Token', user.authentication_token)
      render json: user.as_json, status: :created
    end
    create_user.on(:create_user_failed) do |user|
      warden.custom_failure!
      render json: user.errors, status: :unprocessable_entity
    end
    create_user.call(sign_up_params)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :provider, :uid, :name)
  end
end
