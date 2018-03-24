class AddTypeToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :type, :string
  end
end
