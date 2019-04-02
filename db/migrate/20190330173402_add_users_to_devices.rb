class AddUsersToDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :devices, :user, foreign_key: true
  end
end
