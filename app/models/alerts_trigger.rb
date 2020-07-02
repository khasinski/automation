# frozen_string_literal: true

class AlertsTrigger < ApplicationRecord
  belongs_to :alert
  belongs_to :trigger
end
