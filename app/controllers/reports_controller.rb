class ReportsController < ApplicationController
  include BCrypt

  def new
  end

  def create
    access_token = params.dig(:device, :authentication_token)
    device = find_device
    authorised = access_token && (access_token == device.authentication_token)
    return render json: "Unauthorized", status: 401 unless authorised
    access_token = BCrypt::Password.create(access_token)
    device.update_column(:authentication_token, access_token)
    reports_array = device_reports.to_h.collect {|k,v| {k => v} }
    device.report_metrics(reports_array)

    render json: {authentication_token: access_token}, status: 200
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def device_params
    params.require(:device).permit(:authentication_token, :name, :turn_on_time, :turn_off_time, :intensity, :on_temperature, :off_temperature, :on_volume, :off_volume, :group, :temperature_set, :status, :on)
  end

  def device_reports
    params.require(:device).require(:reports).permit(:temperature, :volume, :test)
  end

  def find_device
    Device.friendly.find(params[:id])
  end
end
