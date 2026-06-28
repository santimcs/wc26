class KnockoutTeam < ApplicationRecord
  belongs_to :team

  enum position: {
    winner: 0,
    runner_up: 1,
    third_place: 2
  }

  validates :team_id, uniqueness: { scope: :group_letter }
  validates :group_letter, :position, presence: true
end