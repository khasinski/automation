class Api::BaseController < ActionController::Base
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
  alias_method :devise_current_user, :current_user

  def user_signed_in?
    !current_user.nil?
  end
  alias_method :devise_user_signed_in?, :user_signed_in?

  def authenticate_user_from_token!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find_by(email: @decoded.first["user_email"])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def jwt_token user
    # 2 Weeks
    expires = Time.now.to_i + (3600 * 24 * 14)
    JWT.encode({:user => user[:email], :exp => expires}, "YOURSECRETKEY", 'HS256')
  end

  def render_unauthorized(payload = { errors: { unauthorized: ["You are not authorized perform this action."] } })
    render json: payload.merge(response: { code: 401 }), status: 401
  end

  def token_from_request
    # Accepts the token either from the header or a query var
    # Header authorization must be in the following format
    # Authorization: Bearer {yourtokenhere}
    auth_header = request.headers['Authorization'] and token = auth_header.split(' ').last
    if(token.to_s.empty?)
      token = request.parameters["token"]
    end

    token
  end

end
