require 'csv'

# Ensure channel and criterium exist
Channel.find_or_create_by(id: 1) do |c|
  c.number = 1
  c.name = "Default"
  c.logo = "default.png"
  c.url = "default.com"
end

Criterium.find_or_create_by(id: 1) do |cr|
  cr.show_date = Date.new(2026, 6, 12)
end

# Load existing sessions
session_hash = Session.all.index_by { |s| s.time.strftime("%H:%M") }
max_seq = Session.maximum(:sequence) || 0

def find_or_create_session(time_str, session_hash, max_seq)
  hour, min = time_str.split(':').map(&:to_i)
  time_obj = Time.new(2000, 1, 1, hour, min, 0)
  key = time_obj.strftime("%H:%M")
  return session_hash[key] if session_hash.key?(key)
  max_seq += 1
  session = Session.create!(sequence: max_seq, time: time_obj)
  session_hash[key] = session
  puts "New session: #{time_str}"
  session
end

csv_path = Rails.root.join('db/data/2026/fixtures_18_to_28.csv')
unless File.exist?(csv_path)
  puts "File not found: #{csv_path}"
  exit
end

count = 0
CSV.foreach(csv_path, headers: true) do |row|
  home_name = row['Home team'].gsub('Czechia', 'Czech Republic').gsub('USA', 'United States')
  away_name = row['Away team'].gsub('Czechia', 'Czech Republic').gsub('USA', 'United States')

  home_team = Team.find_by(name: home_name)
  away_team = Team.find_by(name: away_name)
  next unless home_team && away_team

  date = Date.strptime(row['Date'], '%m/%d/%Y')
  time_str = row['Time'].strip
  session = find_or_create_session(time_str, session_hash, max_seq)

  round = Round.find_by(name: row['Round'].strip)
  next unless round

  Fixture.create!(
    round: round,
    date: date,
    session: session,
    home_team: home_team,
    away_team: away_team,
    channel_id: 1,
    criterium_id: 1
  )
  count += 1
  print "."
end

puts "\nImported #{count} fixtures."