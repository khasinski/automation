FactoryBot.define do
  factory :device do
    name { "cool_device" }
    encrypted_password { Device.new.send(:password_digest, "password") }
    authentication_token { "$2a$04$gHskKHQfRqUji1x1SKssE.nxIPDqpnACibjSDH8yccExV7Co2gy8y" }
    turn_on_time { 3.hours.ago.to_i }
    turn_off_time { 4.hours.from_now.to_i }
    intensity {  {658=>{:red=>"10", :green=>"40", :blue=>"0", :white=>"10"}} }
    on { true }
    type { "Light" }
  end



end
