# frozen_string_literal: true

class AddValveOnToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :valve_on, :boolean, default: false
  end
end
