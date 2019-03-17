class AddAquariumControllerIdToDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :devices, :aquarium_controller, index: true
  end
end
