FactoryBot.define do
  factory :gaming_session do
    association :team
    finished_at { "2025-02-01 18:06:38" }
    note { "A note about this session" }
    with_cheating { false }
  end
end
