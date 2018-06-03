class DeviceSessionsController < ApplicationController
  include BCrypt

  def new_session
    return render json: "Invalid credentials", status: 401 unless params[:device]
    name = device_params[:name]
    password = device_params[:password]
    device = Device.find_by(name: name)
    if device && device.valid_password?(password)
      access_token = BCrypt::Password.create(password)
      device.update_column(:authentication_token, access_token)
       render json: {authentication_token: access_token}, status: 200
    else
      render json: "Invalid credentials", status: 401
    end
  end

  private

  def device_params
    params.require(:device).permit(:name, :password)
  end

end
