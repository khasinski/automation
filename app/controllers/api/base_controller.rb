# frozen_string_literal: true

class Api::BaseController < ApplicationController
  include ActionController::ImplicitRender
  respond_to :json

  before_action :authenticate_user_from_token!

  protected

  def current_user
    if token_from_request.blank?
      nil
    else
      authenticate_user_from_token!
    end
  end
  alias devise_current_user current_user

  def user_signed_in?
    !current_user.nil?
  end
  alias devise_user_signed_in? user_signed_in?

  def jwt_token(user)
    # 2 Weeks
    expires = Time.now.to_i + (3600 * 24 * 14)
    JWT.encode({ user: user[:email], exp: expires }, 'YOURSECRETKEY', 'HS256')
  end

  def token_from_request
    # Accepts the token either from the header or a query var
    # Header authorization must be in the following format
    # Authorization: Bearer {yourtokenhere}
    auth_header = request.headers['Authorization'] and token = auth_header.split(' ').last
    token = request.parameters['token'] if token.to_s.empty?

    token
  end
end
