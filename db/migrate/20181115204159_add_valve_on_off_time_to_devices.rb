class AddValveOnOffTimeToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :valve_on_time, :integer
    add_column :devices, :valve_off_time, :integer
  end
end
