class DevicesController < ApplicationController
  include BCrypt

  def show
    device = find_device
    if device.present?
      render json: {device: device}, status: 200
    else
      render json: {error: "Not found"}, status: 404
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def report
    access_token = params.dig(:device, :authentication_token)
    device = find_device
    authorised = access_token && (access_token == device.authentication_token)
    return render json: "Unauthorized", status: 401 unless authorised
    access_token = BCrypt::Password.create(access_token)
    device.update_column(:authentication_token, access_token)
    device.update_attributes(device_reports)

    render json: {authentication_token: access_token}, status: 200
  end

  private

  def device_params
    params.require(:device).permit(:authentication_token, :name, :turn_on_time, :turn_off_time, :intensity, :on_temperature, :off_temperature, :on_volume, :off_volume, :group, :temperature_set, :status, :on)
  end

  def device_reports
    params.require(:device).permit(:temperature, :volume)
  end

  def find_device
    Device.friendly.find(params[:id])
  end

end
