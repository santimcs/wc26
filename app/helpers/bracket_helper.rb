module BracketHelper
  def winner_class(fixture, result, side)
    return '' unless result

    winner = if result.home_goals > result.away_goals
               fixture.home_team
             elsif result.home_goals < result.away_goals
               fixture.away_team
             elsif result.home_penalties.present? && result.away_penalties.present?
               if result.home_penalties > result.away_penalties
                 fixture.home_team
               elsif result.home_penalties < result.away_penalties
                 fixture.away_team
               else
                 nil
               end
             else
               nil
             end

    return '' unless winner

    team = side == 'home' ? fixture.home_team : fixture.away_team
    team == winner ? 'winner' : ''
  end
end
