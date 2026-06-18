class StandingsController < ApplicationController
  def index
    @standings = Standing.includes(:team).all
    
    # Sort with nil handling
    @standings = @standings.sort_by do |s|
      [
        s.team.group,
        -(s.safe_points),
        -(s.safe_goal_difference),
        -(s.safe_goals_for)
      ]
    end
    
    @groups = @standings.group_by { |s| s.team.group }
  end
  
  def show
    @standing = Standing.find(params[:id])
  end
  
  def recalculate
    # Recalculate all standings from results
    Standing.delete_all
    
    Result.all.each do |result|
      result.send(:update_standings)
    end
    
    redirect_to standings_path, notice: "Standings recalculated successfully!"
  end

  def init
  Team.all.each do |team|
    standing = Standing.find_or_initialize_by(team: team)
    standing.update(
      played: 0,
      wins: 0,
      draws: 0,
      losses: 0,
      goals_for: 0,
      goals_against: 0,
      points: 0
    )
    end
    redirect_to standings_path, notice: "Standings initialized for #{Standing.count} teams!"
  end

end