FactoryBot.define do
  factory :match do
    association :gaming_session
    name { "Drako vs Myra in Chess" }
  end
end
