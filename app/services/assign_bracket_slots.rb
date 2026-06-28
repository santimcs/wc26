class AssignBracketSlots
  def self.call
    new.call
  end

  def call
    round = Round.find_by(name: 'Round of 32')
    return unless round

    fixtures = Fixture.where(round: round).order(:date, :session_id) # maybe also by time

    slot = 1
    fixtures.each do |fixture|
      home_team = fixture.home_team
      away_team = fixture.away_team
      # Find knockout_team record for each
      kt_home = KnockoutTeam.find_by(team: home_team)
      kt_away = KnockoutTeam.find_by(team: away_team)
      if kt_home
        kt_home.update!(bracket_slot: slot)
        slot += 1
      else
        puts "Warning: Home team #{home_team.name} not found in knockout_teams"
      end
      if kt_away
        kt_away.update!(bracket_slot: slot)
        slot += 1
      else
        puts "Warning: Away team #{away_team.name} not found in knockout_teams"
      end
    end
    puts "Assigned bracket slots up to #{slot-1}"
  end
end