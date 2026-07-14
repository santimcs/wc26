class BracketController < ApplicationController

  def index
  rounds = Round.where(sequence: 2..6).order(:sequence)
  @bracket = {}

  rounds.each do |round|
    fixtures = Fixture.where(round: round)
                      .includes(:home_team, :away_team, :round, :session, :results)
                      .order(:date, :session_id, :id)
    @bracket[round.id] = fixtures
  end

  end

end