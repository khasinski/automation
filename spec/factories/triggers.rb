FactoryBot.define do
  factory :trigger do
    name { "basic trigger" }
    conditions { {device: "my_device", metric: "my_metric", operator: "<", value: 10} }
    type { "" }
  end

end
