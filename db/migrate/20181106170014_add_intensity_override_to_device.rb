# frozen_string_literal: true

class AddIntensityOverrideToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :intensity_override, :string
  end
end
