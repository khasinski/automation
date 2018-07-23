FactoryBot.define do
  factory :device do
    name { "cool_device" }
    encrypted_password { Device.new.send(:password_digest, "password") }
    authentication_token { "$2a$04$gHskKHQfRqUji1x1SKssE.nxIPDqpnACibjSDH8yccExV7Co2gy8y" }
    turn_on_time { 3.hours.ago.to_i }
    turn_off_time { 4.hours.from_now.to_i }
    intensity { 50 }
    on { true }
    type { "Light" }
  end



end
