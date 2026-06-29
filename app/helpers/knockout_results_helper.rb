module KnockoutResultsHelper
  def fixture_display_with_round(fixture)
    round = fixture.round.name
    home = fixture.home_team&.name || 'TBD'
    away = fixture.away_team&.name || 'TBD'
    date = fixture.date&.strftime('%b %d') || 'TBD'
    "#{round}: #{home} vs #{away} (#{date})"
  end
end