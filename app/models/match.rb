class Match < ApplicationRecord
  # 🚅 add concerns above.

  # 🚅 add attribute accessors above.

  belongs_to :gaming_session
  # 🚅 add belongs_to associations above.

  has_many :joined_players, class_name: "Matches::JoinedPlayer", dependent: :destroy
  has_many :players, through: :joined_players
  # 🚅 add has_many associations above.

  has_one :team, through: :gaming_session
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def valid_players
    team.players
  end

  # 🚅 add methods above.
end
