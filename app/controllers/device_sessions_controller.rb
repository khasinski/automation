class DeviceSessionsController < ApplicationController
  include BCrypt
  skip_before_action :authenticate_user_from_token!

  def new_session
    return render json: "Invalid credentials", status: 401 unless params[:device]
    sign_in_device = SignInDevice.new
    sign_in_device.on(:sign_in_device_success) do |device|
      render json: {authentication_token: device.authentication_token}, status: 200
    end
    sign_in_device.on(:sign_in_device_failed) { render json: "Invalid credentials", status: 401 }
    @current_ip = request.remote_ip
    sign_in_device.call(device_params, @current_ip)
  end

  private

  def device_params
    params.require(:device).permit(:name, :password)
  end

end
