class Result < ApplicationRecord
  belongs_to :fixture
  after_save :update_standings, unless: :knockout_fixture?
   after_save :advance_winner,   if: :knockout_fixture?
  after_destroy :revert_standings, unless: :knockout_fixture?
  
  validates :home_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :away_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  private

  def advance_winner
    AdvanceKnockoutWinner.call(self)
  end

  def knockout_fixture?
    # Group round has sequence = 1; all others (>=2) are knockout
    fixture.round.sequence >= 2
  end
  
  def update_standings
    # Update home team standings
    update_team_standing(fixture.home_team, home_goals, away_goals, true)
    # Update away team standings
    update_team_standing(fixture.away_team, away_goals, home_goals, false)
  end
  
  def revert_standings
    # Subtract points and goals
    update_team_standing(fixture.home_team, -home_goals, -away_goals, true, true)
    update_team_standing(fixture.away_team, -away_goals, -home_goals, false, true)
  end
  
  def update_team_standing(team, goals_for, goals_against, is_home, is_revert = false)
    standing = Standing.find_or_initialize_by(team: team)
    
    multiplier = is_revert ? -1 : 1
    
    # Update goals
    standing.goals_for = (standing.goals_for || 0) + (goals_for * multiplier)
    standing.goals_against = (standing.goals_against || 0) + (goals_against * multiplier)
    standing.played = (standing.played || 0) + (1 * multiplier)
    
    # Calculate points based on result
    if goals_for > goals_against
      # Win
      standing.wins = (standing.wins || 0) + (1 * multiplier)
      standing.points = (standing.points || 0) + (3 * multiplier)
    elsif goals_for < goals_against
      # Loss
      standing.losses = (standing.losses || 0) + (1 * multiplier)
    else
      # Draw
      standing.draws = (standing.draws || 0) + (1 * multiplier)
      standing.points = (standing.points || 0) + (1 * multiplier)
    end
    
    standing.save
  end
end