class Device < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  validates :type, inclusion: { in: %w(AquariumController Light) }

  def report_metrics(metrics_array)
    Reports.new(self.name).write_data_points(metrics_array)
  end

  def get_metrics(metric_name)
    Reports.new(self.name).read_data_points(metric_name)
  end
end
