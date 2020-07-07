# frozen_string_literal: true

class AddValveOnOffTimeToDevices < ActiveRecord::Migration[5.1]
  def change
    change_table :devices, bulk: true do |t|
      t.integer :valve_on_time
      t.integer :valve_off_time
    end
  end
end
