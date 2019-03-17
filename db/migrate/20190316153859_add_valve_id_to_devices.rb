class AddValveIdToDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :devices, :valve_controller, index: true
  end
end
