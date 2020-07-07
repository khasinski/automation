# frozen_string_literal: true

class DeviceSessionsController < Api::BaseController
  skip_before_action :authenticate_user_from_token!

  def new_session
    return render json: 'Invalid credentials', status: :unauthorized unless params[:device]

    sign_in_device = SignInDevice.new
    sign_in_device.on(:sign_in_device_success) do |device|
      render json: { authentication_token: device.authentication_token }, status: :ok
    end
    sign_in_device.on(:sign_in_device_failed) { render json: 'Invalid credentials', status: :unauthorized }
    @current_ip = request.remote_ip
    sign_in_device.call(device_params, @current_ip)
  end

  private

  def device_params
    params.require(:device).permit(:name, :password)
  end
end
