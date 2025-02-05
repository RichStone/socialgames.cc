FactoryBot.define do
  factory :player do
    association :team
    username { "MyString" }
  end
end
