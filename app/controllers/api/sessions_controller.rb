# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    before_action :ensure_params_exist

    def create
      user = User.find_for_database_authentication(email: sign_in_params[:email])
      return invalid_login_attempt unless user
      return invalid_login_attempt unless user.valid_password?(sign_in_params[:password])

      auth_token = ::JsonWebToken.encode(user_email: user.email)
      bearer_token = "Bearer #{auth_token}"
      user.update(authentication_token: auth_token)
      response.set_header('Authorization', bearer_token)
      render json: {}, status: :ok
    end

    private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end

    def ensure_params_exist
      return unless params[:user].blank? || sign_in_params[:email].blank? || sign_in_params[:password].blank?

      render_unauthorized errors: { unauthenticated: ['Incomplete credentials'] }
    end

    def invalid_login_attempt
      render_unauthorized errors: { unauthenticated: ['Invalid credentials'] }
    end

    def render_unauthorized(payload = { errors: { unauthorized: ['You are not authorized perform this action.'] } })
      render json: payload.merge(response: { code: 401 }), status: :unauthorized
    end
  end
end
