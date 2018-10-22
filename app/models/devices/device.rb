class Device < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  validates :type, inclusion: { in: %w(AquariumController Light) }

  serialize :intensity, Hash

  def report_metrics(metrics_array)
    Reports.new(self.name).write_data_points(metrics_array)
  end

  def get_metrics(metric_name, time_ago = 24, unit = 'h')
    reports = Reports.new(self.name).read_data_points(metric_name, time_ago, unit).first.values[2]
    reports.map {|d| [ Time.at(d["time"]).to_s(:time), d[metric_name]] }
  end

  def show_actual_intensity
    latest_intensity = {:red=>"0", :green=>"0", :blue=>"0", :white=>"0"}
    current_time = Time.now
    self.intensity.each do |minutes, values|
      if minutes.to_i > (current_time.hour*60 + current_time.min)
        latest_intensity = values
      else
        break
      end
    end
    return latest_intensity
  end

  def add_intensity(time, intensity)
    minutes = time.min + time.hour*60
    intensity = self.intensity.merge(minutes => intensity)
    self.update_attribute(:intensity, intensity.sort.to_h)
  end

  def permitted_settings
    settings = attributes.deep_symbolize_keys.except(*hidden_fields) if defined? hidden_fields
    settings.merge(intensity: show_actual_intensity)
  end
end
