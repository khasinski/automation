# frozen_string_literal: true

class AddSettingsToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :turn_on_time, :integer
    add_column :devices, :turn_off_time, :integer
    add_column :devices, :intensity, :integer
    add_column :devices, :on_temperature, :integer
    add_column :devices, :off_temperature, :integer
    add_column :devices, :on_volume, :integer
    add_column :devices, :off_volume, :integer
    add_column :devices, :group, :string
    add_column :devices, :temperature_set, :decimal
  end
end
