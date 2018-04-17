require 'rails_helper'
class DeviceSessionsController < ApplicationController
    include BCrypt

    def new_session
      name = params[:device][:name] if params[:device]
      password = params[:device][:password] if params[:device]
      device = Device.find_by(name: name)
      if device
        device.valid_password?(password)
        access_token = BCrypt::Password.create(password)
        device.update_column(:authentication_token, access_token)
        render json: {authentication_token: access_token}, status: 200
      else
        render json: "Invalid credentials", status: 401
      end
    end
end
