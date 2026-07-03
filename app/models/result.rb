class Result < ApplicationRecord
  belongs_to :fixture

  after_save :update_standings, unless: :knockout_fixture?
  after_save :advance_winner, if: :knockout_fixture?
  after_destroy :revert_standings, unless: :knockout_fixture?

  validates :home_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :away_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # ========== PUBLIC METHODS ==========
  def winner_team
    if home_goals > away_goals
      fixture.home_team
    elsif home_goals < away_goals
      fixture.away_team
    else
      # Draw – check penalties
      if home_penalties.present? && away_penalties.present?
        if home_penalties > away_penalties
          fixture.home_team
        elsif home_penalties < away_penalties
          fixture.away_team
        else
          nil # Still a draw (should not happen)
        end
      else
        nil # No winner (no penalties entered)
      end
    end
  end

  # ========== PRIVATE METHODS ==========
  private

  def knockout_fixture?
    fixture.round.sequence >= 2
  end

  def advance_winner
    AdvanceKnockoutWinner.call(self)
  end

  def update_standings
    update_team_standing(fixture.home_team, home_goals, away_goals, true)
    update_team_standing(fixture.away_team, away_goals, home_goals, false)
  end

  def revert_standings
    update_team_standing(fixture.home_team, -home_goals, -away_goals, true, true)
    update_team_standing(fixture.away_team, -away_goals, -home_goals, false, true)
  end

  def update_team_standing(team, goals_for, goals_against, is_home, is_revert = false)
    standing = Standing.find_or_initialize_by(team: team)
    multiplier = is_revert ? -1 : 1

    standing.goals_for = (standing.goals_for || 0) + (goals_for * multiplier)
    standing.goals_against = (standing.goals_against || 0) + (goals_against * multiplier)
    standing.played = (standing.played || 0) + (1 * multiplier)

    if goals_for > goals_against
      standing.wins = (standing.wins || 0) + (1 * multiplier)
      standing.points = (standing.points || 0) + (3 * multiplier)
    elsif goals_for < goals_against
      standing.losses = (standing.losses || 0) + (1 * multiplier)
    else
      standing.draws = (standing.draws || 0) + (1 * multiplier)
      standing.points = (standing.points || 0) + (1 * multiplier)
    end

    standing.save
  end
end