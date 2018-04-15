class AddAccessTokenToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :access_token, :string
  end
end
