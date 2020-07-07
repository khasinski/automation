# frozen_string_literal: true

class Alert < ApplicationRecord
  belongs_to :user
  has_many :triggers, through: :alerts_triggers
end
