class ChangeDeviceValveColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :devices, :valve_on_time, :co2valve_on_time
    rename_column :devices, :valve_off_time, :co2valve_off_time
    rename_column :devices, :valve_on, :water_input_valve_on
  end
end
