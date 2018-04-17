class AddMeasurementsToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :temperature, :decimal
    add_column :devices, :volume, :decimal
  end
end
