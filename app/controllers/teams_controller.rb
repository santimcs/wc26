class TeamsController < ApplicationController
  def index
    @teams = Team.order(:group, :ranking)
  end
  
  def show
    @team = Team.find(params[:id])
  end
end
