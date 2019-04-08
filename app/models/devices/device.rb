class Device < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  validates :type, inclusion: { in: %w(AquariumController Light ValveController) }

  serialize :intensity, Hash
  serialize :intensity_override, Hash
  serialize :connected_devices, Hash
  belongs_to :user
  has_many :charts

  def report_metrics(metrics_array)
    Reports.new(self.name).write_data_points(metrics_array)
  end

  def get_metrics(metric_name, time_ago = 24, unit = 'h')
    data_points = Reports.new(self.name).read_data_points(metric_name, time_ago, unit).first
    reports = data_points.values[2] if data_points || []
    reports.map {|d| [ Time.at(d["time"]).to_s(:time), d[metric_name]] }
  end

  def show_actual_intensity
    return intensity_override unless intensity_override.empty?
    latest_intensity = self.intensity.values.last
    current_time = Time.now
    scale_factor = self.light_intensity_lvl || 1

    self.intensity.each do |minutes, values|
      if minutes.to_i <= (current_time.hour*60 + current_time.min)
        latest_intensity = values
      else
        break
      end
    end
    latest_intensity.each {|k,v| latest_intensity[k] = (scale_factor*v).ceil.to_i}
  end

  def add_intensity(time, intensity)
    minutes = time.min + time.hour*60
    intensity = self.intensity.merge(minutes => intensity)
    self.update_attribute(:intensity, intensity.sort.to_h)
  end

  def co2valve_on?
    minutes = Time.now.min + Time.now.hour*60
    self.co2valve_on_time <= minutes && self.co2valve_off_time >= minutes
  end

  def send_update_request(param, json_data)
    %x(curl -X POST -H 'content-type: application/json' -d '#{json_data}' #{current_sign_in_ip}/update_#{param}) if self.current_sign_in_ip
  end

  def permitted_settings
    settings = attributes.deep_symbolize_keys.except(*hidden_fields) if defined? hidden_fields
    settings.merge!(intensity: show_actual_intensity) unless self.intensity.blank?
    settings.merge!(co2valve_on: co2valve_on?) if self.co2valve_on_time && self.co2valve_off_time
    settings
  end
end
