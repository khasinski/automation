# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'user@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    authentication_token { JsonWebToken.encode(user_email: 'user@gmail.com') }
    name { Faker::Name.name }
  end
end
