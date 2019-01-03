class AddLightIntensityLvlToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :light_intensity_lvl, :float
  end
end
