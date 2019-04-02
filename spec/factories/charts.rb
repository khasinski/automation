FactoryBot.define do
  factory :chart do
    name { "MyString" }
    metric { "MyString" }
    default_duration { 1 }
    default_duration_unit { "MyString" }
  end
end
