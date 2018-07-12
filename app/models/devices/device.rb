class Device < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  validates :type, inclusion: { in: %w(AquariumController Light) }

  def report_metrics(metrics_array)
    data = map_metrics_array_to_data(metrics_array)
    Reports.new.write_data_points(data)
  end

  def data_point(data_name, value)
    {
      series: self.name,
      values: Hash[data_name, value]
    }.deep_symbolize_keys
  end

  def map_metrics_array_to_data(ar)
    ar.map do |metric|
      key, val = metric.first
      data_point(key, val)
    end
  end


  def get_metrics(metric_name)
    Reports.new.read_data_points(metric_name, self.name)
  end
end
