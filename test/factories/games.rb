FactoryBot.define do
  factory :game do
    association :team
    name { "MyString" }
  end
end
