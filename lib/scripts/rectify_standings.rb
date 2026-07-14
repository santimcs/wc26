# lib/scripts/rectify_standings.rb
# Run with: rails runner lib/scripts/rectify_standings.rb

puts "🚀 Resetting standings..."
Standing.delete_all

# Get all teams (48 teams)
teams = Team.all

# Initialize standings with zeros
teams.each do |team|
  Standing.create!(
    team: team,
    played: 0,
    wins: 0,
    draws: 0,
    losses: 0,
    goals_for: 0,
    goals_against: 0,
    points: 0,
    form: ''
  )
end

puts "✅ Created #{Standing.count} standings."

# Group stage round (sequence = 1)
group_round = Round.find_by(sequence: 1)
unless group_round
  puts "❌ Group round not found! (sequence = 1)"
  exit
end

# Get all group fixtures with results (excluding matches without results)
group_fixtures = Fixture.where(round: group_round)
                        .joins(:results)
                        .includes(:results, :home_team, :away_team)
                        .order(:date, :session_id)

puts "📋 Found #{group_fixtures.count} group fixtures with results."

# First, update the standings with goals and points
group_fixtures.each do |fixture|
  result = fixture.results.first
  home_goals = result.home_goals
  away_goals = result.away_goals

  home_standing = Standing.find_by(team: fixture.home_team)
  away_standing = Standing.find_by(team: fixture.away_team)

  # Update home team
  home_standing.played += 1
  home_standing.goals_for += home_goals
  home_standing.goals_against += away_goals

  # Update away team
  away_standing.played += 1
  away_standing.goals_for += away_goals
  away_standing.goals_against += home_goals

  # Determine results
  if home_goals > away_goals
    home_standing.wins += 1
    home_standing.points += 3
    away_standing.losses += 1
  elsif home_goals < away_goals
    away_standing.wins += 1
    away_standing.points += 3
    home_standing.losses += 1
  else
    home_standing.draws += 1
    away_standing.draws += 1
    home_standing.points += 1
    away_standing.points += 1
  end

  home_standing.save!
  away_standing.save!
end

puts "✅ Updated standings with goals and points."

# Now update the form string for each team
# We need to get last 3 group results for each team, in chronological order (most recent first)

puts "📝 Updating form strings..."

Team.all.each do |team|
  # Get results where team played in a group fixture, ordered by date descending, session descending
  results = Result.joins(fixture: :round)
                  .where(fixtures: { round_id: group_round.id })
                  .where('fixtures.home_team_id = ? OR fixtures.away_team_id = ?', team.id, team.id)
                  .order('fixtures.date DESC, fixtures.session_id DESC')
                  .limit(3)

  form_string = results.map do |r|
    fixture = r.fixture
    if fixture.home_team_id == team.id
      r.home_goals > r.away_goals ? 'W' : (r.home_goals < r.away_goals ? 'L' : 'D')
    else
      r.away_goals > r.home_goals ? 'W' : (r.away_goals < r.home_goals ? 'L' : 'D')
    end
  end.join

  standing = Standing.find_by(team: team)
  standing.update_column(:form, form_string)
end

puts "✅ Form strings updated."

# Final summary
puts "\n🏆 Standings rectification complete!"
puts "Total teams: #{Team.count}"
puts "Total standings: #{Standing.count}"
puts "Group fixtures with results: #{group_fixtures.count}"