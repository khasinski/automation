require 'jwt'
class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, expiration = 24.hours.from_now)
    payload = payload.dup
    payload['exp'] = expiration.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)
  end
end
