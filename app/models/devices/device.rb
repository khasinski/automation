class Device < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  def self.report_metric(metric_name, value)
    tag_hash = {
      device_name: self.name,
      status: self.status
    }
    Metrics.new.write_data_point(metric_name, value, tag_hash)
  end
end
