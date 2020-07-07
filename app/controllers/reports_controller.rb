# frozen_string_literal: true

class ReportsController < Api::BaseController
  require 'uri'
  include BCrypt
  skip_before_action :authenticate_user_from_token!
  before_action :ensure_device, only: %i[create show]
  before_action :authenticate_device, only: [:create]
  before_action :authenticate_user, only: [:show]

  def new; end

  def create
    filtered_reports = device_reports.except('checkin')
    reports_array = filtered_reports.to_h.collect { |k, v| { k => v } }
    device.report_metrics(reports_array) unless reports_array.empty?
    # my_logger = Logger.new("#{Rails.root}/log/my.log")
    # my_logger.info("Settings: #{device.permitted_settings.compact.to_s}")
    render json: { settings: device.permitted_settings.compact }, status: :ok
  end

  def update; end

  def edit; end

  def destroy; end

  def index; end

  def show
    data = device.get_metrics(params_report_name)
    render json: data, status: :ok
  end

  private

  def authenticate_device
    access_token = request.env['HTTP_AUTHORIZATION']
    authorized = access_token && (access_token == device.authentication_token)
    return render json: 'Unauthorized', status: :unauthorized unless authorized
  end

  def params_report_name
    params.dig(:device, :reports, :name)
  end

  def authenticate_user
    redirect_to new_user_session_url unless user_signed_in?
  end

  def device_params
    params.require(:device).permit(
      :authentication_token, :name, :turn_on_time, :turn_off_time,
      :intensity, :on_temperature, :off_temperature, :on_volume,
      :off_volume, :group, :temperature_set, :status, :on
    )
  end

  def device_reports
    params.require(:device).require(:reports).permit(:checkin, :temperature, :volume, :test, :distance)
  end

  def device
    @device ||= Device.friendly.find(params.dig(:device, :name))
  end

  def ensure_device
    return render json 'No such device', status: 404 unless device
  end
end
