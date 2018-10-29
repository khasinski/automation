class ReportsController < ApplicationController
  require 'uri'
  include BCrypt
  before_action :ensure_device, only: [:create, :show]
  before_action :authenticate_device, only: [:create]
  before_action :authenticate_user, only: [:show]

  def new
  end

  def create
    reports_array = device_reports.to_h.collect {|k,v| {k => v} }
    device.report_metrics(reports_array)
    render json: {settings: device.permitted_settings.compact}, status: 200
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
    data = device.get_metrics(get_params_report_name)
    return render json: data, status: 200
  end

  private

  def authenticate_device
    access_token = request.env["HTTP_AUTHORIZATION"]
    authorized = access_token && (access_token == device.authentication_token)
    return render json: "Unauthorized", status: 401 unless authorized
  end

  def get_params_report_name
    params.dig(:device, :reports, :name)
  end

  def authenticate_user
    redirect_to new_user_session_url unless user_signed_in?
  end

  def device_params
    params.require(:device).permit(:authentication_token, :name, :turn_on_time, :turn_off_time, :intensity, :on_temperature, :off_temperature, :on_volume, :off_volume, :group, :temperature_set, :status, :on)
  end

  def device_reports
    params.require(:device).require(:reports).permit(:temperature, :volume, :test, :distance)
  end

  def device
    @device ||= Device.friendly.find(params.dig(:device, :name))
  end

  def ensure_device
    return render json "No such device", status: 404 unless device
  end
end
