class DevicesController < ApplicationController

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

  def device_settings
    device = find_device
    render json: {settings: device_type_settings(device)}, status: 200
  end

  private

  def device_type_settings(device)
    case device.type
    when "Light"
      light_settings(device)
    when "AquariumController"
      aquarium_controller_settings(device)
    else
      raise "Incorrect device type."
    end
  end

  def light_settings(device)
    {
      "turn_on_time" => device.turn_on_time,
      "turn_off_time" => device.turn_off_time,
      "intensity" => device.intensity,
      "status" => device.status,
      "on" => device.on?
      }
  end

  def aquarium_controller_settings(device)
    {
      "turn_on_time" => device.turn_on_time,
      "turn_off_time" => device.turn_off_time,
      "intensity" => device.intensity,
      "status" => device.status,
      "on" => device.on?,
      "temperature_set"=> device.temperature_set
      }
  end

  def device_params
    params.require(:device).permit(:authentication_token, :name, :turn_on_time, :turn_off_time, :intensity, :on_temperature, :off_temperature, :on_volume, :off_volume, :group, :temperature_set, :status, :on)
  end

  def find_device
    Device.friendly.find(params[:id])
  end

end
