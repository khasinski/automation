# frozen_string_literal: true

class RemoveTemperatureFromDevices < ActiveRecord::Migration[5.1]
  def change
    change_table :devices, bulk: false do |t|
      t.decimal :temperature
    end
  end
end
