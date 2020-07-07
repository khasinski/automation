# frozen_string_literal: true

class AddConnectedDevicesToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :connected_devices, :string
  end
end
