class AddStatusToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :status, :string
    add_column :devices, :on, :boolean
  end
end
