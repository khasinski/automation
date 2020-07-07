# frozen_string_literal: true

class AddSettingsToDevices < ActiveRecord::Migration[5.1]
  def change
    change_table :devices, bulk: true do |t|
      t.integer :turn_on_time
      t.integer :turn_off_time
      t.integer :intensity
      t.integer :on_temperature
      t.integer :off_temperature
      t.integer :on_volume
      t.integer :off_volume
      t.string :group
      t.decimal :temperature_set
    end
  end
end
