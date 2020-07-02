# frozen_string_literal: true

class SignInDevice
  include Wisper::Publisher

  def call(sign_in_params, remote_ip)
    name = sign_in_params[:name]
    password = sign_in_params[:password]
    device = Device.find_by(name: name)
    if device&.valid_password?(password)
      access_token = BCrypt::Password.create(password)
      current_ip = remote_ip
      device.update_columns(authentication_token: access_token, last_sign_in_ip: current_ip, current_sign_in_ip: current_ip)
      broadcast(:sign_in_device_success, device)
    else
      broadcast(:sign_in_device_failed)
    end
  end
end
