class Standing < ApplicationRecord
  belongs_to :team
  
  validates :team_id, uniqueness: true
  
  def goal_difference
    (goals_for || 0) - (goals_against || 0)
  end
  
  def points_per_game
    return 0 if played.nil? || played == 0
    (points.to_f / played).round(2)
  end
  
  def form(limit = 5)
    # Get last 'limit' results for this team
    fixtures = Fixture.where("home_team_id = ? OR away_team_id = ?", team.id, team.id)
                      .order(date: :desc)
                      .limit(limit)
    
    form_string = ""
    fixtures.each do |fixture|
      result = Result.find_by(fixture: fixture)
      next unless result
      
      if fixture.home_team_id == team.id
        if result.home_goals > result.away_goals
          form_string += "W"
        elsif result.home_goals < result.away_goals
          form_string += "L"
        else
          form_string += "D"
        end
      else
        if result.away_goals > result.home_goals
          form_string += "W"
        elsif result.away_goals < result.home_goals
          form_string += "L"
        else
          form_string += "D"
        end
      end
    end
    form_string
  end
  
  # Helper methods for sorting with nil handling
  def safe_points
    points || 0
  end
  
  def safe_goal_difference
    goal_difference || 0
  end
  
  def safe_goals_for
    goals_for || 0
  end
end
