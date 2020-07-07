# frozen_string_literal: true

class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users, bulk: true do |t|
      t.text :authentication_token
      t.datetime :authentication_token_created_at
    end

    add_index :users, :authentication_token, unique: true
  end
end
