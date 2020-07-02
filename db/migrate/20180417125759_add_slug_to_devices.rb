# frozen_string_literal: true

class AddSlugToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :slug, :string, unique: true
  end
end
