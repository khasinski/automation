FactoryBot.define do
  factory :user do
    email { "user@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    authentication_token { JsonWebToken.encode(user_email: "user@gmail.com") }
  end

end
