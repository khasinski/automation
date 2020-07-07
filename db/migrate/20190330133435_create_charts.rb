# frozen_string_literal: true

class CreateCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :charts do |t|
      t.string :name
      t.string :metric
      t.integer :default_duration
      t.string :default_duration_unit
      t.references :user, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
    add_index :charts, :name, unique: true
  end
end
