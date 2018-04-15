
class DeviceSessionsController < ApplicationController
    include BCrypt

    def new_session
      name = params[:device][:name]
      password = params[:device][:password]
      device = Device.find_by(name: name)
      device.valid_password?(password)
      access_token = BCrypt::Password.create(password)
      device.update_column(:access_token, access_token)
    end
end
