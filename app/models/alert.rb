class Alert < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :triggers, through: :alerts_triggers
end
