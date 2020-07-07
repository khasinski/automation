# frozen_string_literal: true

class AddMeasurementsToDevice < ActiveRecord::Migration[5.1]
  def change
    change_table :devices, bulk: true do |t|
      t.decimal :temperature
      t.decimal :volume
    end
  end
end
