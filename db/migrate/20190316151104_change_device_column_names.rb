# frozen_string_literal: true

class ChangeDeviceColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :devices, :volume, :distance
  end
end
