class AdvanceKnockoutWinner
  def self.call(result)
    new(result).call
  end

  def initialize(result)
    @result = result
    @fixture = result.fixture
  end

  def call
    # Only run for knockout fixtures (round sequence >= 2)
    return unless @fixture.round.sequence >= 2

    next_match = @fixture.next_match
    return unless next_match

    # Determine winner
    if @result.home_goals > @result.away_goals
      winner = @fixture.home_team
    elsif @result.home_goals < @result.away_goals
      winner = @fixture.away_team
    else
      # Draw – we'll handle extra time/penalties later
      return
    end

    # Place winner into the next fixture based on winner_slot
    if @fixture.winner_slot == 'home'
      next_match.update!(home_team: winner)
    elsif @fixture.winner_slot == 'away'
      next_match.update!(away_team: winner)
    end
  end
end