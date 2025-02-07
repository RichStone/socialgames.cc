FactoryBot.define do
  factory :matches_joined_player, class: 'Matches::JoinedPlayer' do
    match { nil }
    player { nil }
  end
end
