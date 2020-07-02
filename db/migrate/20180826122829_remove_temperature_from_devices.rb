# frozen_string_literal: true

class RemoveTemperatureFromDevices < ActiveRecord::Migration[5.1]
  def change
    remove_column :devices, :temperature
  end
end
