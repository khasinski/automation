FactoryBot.define do
  factory :device do
    name { Faker::Pokemon.name }
    encrypted_password { Device.new.send(:password_digest, "password") }
    authentication_token { "$2a$04$gHskKHQfRqUji1x1SKssE.nxIPDqpnACibjSDH8yccExV7Co2gy8y" }
  end

end
