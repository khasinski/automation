# frozen_string_literal: true

class CreateAlertsTriggers < ActiveRecord::Migration[6.0]
  def change
    create_table :alerts_triggers, id: false do |t|
      t.belongs_to :alert, index: true, foreign_key: true
      t.belongs_to :trigger, index: true, foreign_key: true
    end
  end
end
