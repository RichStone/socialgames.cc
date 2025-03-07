class Player < ApplicationRecord
  # 🚅 add concerns above.

  # 🚅 add attribute accessors above.

  belongs_to :team
  # 🚅 add belongs_to associations above.

  has_many :joined_matches, class_name: "Matches::JoinedPlayer", dependent: :destroy
  has_many :matches, through: :joined_matches
  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :username, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
