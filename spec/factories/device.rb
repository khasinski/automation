FactoryBot.define do
  factory :device do
    name { Faker::Pokemon.name }
    password { Faker::Internet.password }
    encrypted_password { Device.new.send(:password_digest, password) }
  end

end
