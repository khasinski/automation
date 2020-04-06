FactoryBot.define do
  factory :trigger do
    name { "basic trigger" }
    conditions { {metric: "my_metric", operator: "<", value: 10} }
    type { "" }
  end
end
