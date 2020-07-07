# frozen_string_literal: true

class AddStatusToDevices < ActiveRecord::Migration[5.1]
  def change
    change_table :devices, bulk: true do |t|
      t.string :status
      t.boolean :on
    end
  end
end
