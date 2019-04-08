class RemoveValveControllerFromDevices < ActiveRecord::Migration[5.1]
  def change
    remove_reference :devices, :valve_controller, index: true
    remove_reference :devices, :aquarium_controller, index: true
  end
end
