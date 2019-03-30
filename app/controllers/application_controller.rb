class ApplicationController < Api::BaseController
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    authentication_params = [:email, :usernamename, :password, :password_confirmation, user: [:email, :password]]
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name,:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in, keys: authentication_params)
  end
end
