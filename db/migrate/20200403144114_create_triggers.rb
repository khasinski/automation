# frozen_string_literal: true

class CreateTriggers < ActiveRecord::Migration[6.0]
  def change
    create_table :triggers do |t|
      t.string :name
      t.string :conditions
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
