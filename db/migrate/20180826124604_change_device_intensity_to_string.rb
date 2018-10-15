class ChangeDeviceIntensityToString < ActiveRecord::Migration[5.1]
  def change
    change_column :devices, :intensity, :string
  end
end
