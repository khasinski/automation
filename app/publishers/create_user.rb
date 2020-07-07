# frozen_string_literal: true

class CreateUser
  include Wisper::Publisher

  def call(sign_up_params)
    user = User.new(sign_up_params)
    user.authentication_token = ::JsonWebToken.encode(user_email: user.email)
    user.authentication_token_created_at = Time.zone.now
    if user.save
      broadcast(:create_user_success, user)
    else
      broadcast(:create_user_failed, user)
    end
  end
end
