class Trigger < ApplicationRecord
  belongs_to :user

  def value
    self.conditions["value"]
  end

end
