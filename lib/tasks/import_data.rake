namespace :import do
  desc "Import teams from CSV"
  task teams: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/teams.csv')
    
    if File.exist?(file_path)
      count = 0
      CSV.foreach(file_path, headers: true) do |row|
        team = Team.find_or_initialize_by(name: row['name'])
        team.group = row['group']
        team.ranking = row['ranking'].to_i
        team.flag = row['flag']
        team.confederation = row['confederation']
        
        if team.save
          count += 1
          print "." 
        end
      end
      puts "\n✅ Imported #{count} teams"
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import rounds from CSV"
  task rounds: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/rounds.csv')
    
    if File.exist?(file_path)
      count = 0
      CSV.foreach(file_path, headers: true) do |row|
        round = Round.find_or_initialize_by(sequence: row['sequence'].to_i)
        round.name = row['name']
        
        if round.save
          count += 1
          print "."
        end
      end
      puts "\n✅ Imported #{count} rounds"
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import sessions from CSV"
  task sessions: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/sessions.csv')
    
    if File.exist?(file_path)
      count = 0
      CSV.foreach(file_path, headers: true) do |row|
        session = Session.find_or_initialize_by(sequence: row['sequence'].to_i)
        session.time = row['time']
        
        if session.save
          count += 1
          print "."
        end
      end
      puts "\n✅ Imported #{count} sessions"
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import channels from CSV"
  task channels: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/channels.csv')
    
    if File.exist?(file_path)
      count = 0
      CSV.foreach(file_path, headers: true) do |row|
        channel = Channel.find_or_initialize_by(number: row['number'].to_i)
        channel.name = row['name']
        channel.logo = row['logo']
        channel.url = row['url']
        
        if channel.save
          count += 1
          print "."
        end
      end
      puts "\n✅ Imported #{count} channels"
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import fixtures from CSV"
  task fixtures: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/fixtures.csv')
    
    if File.exist?(file_path)
      count = 0
      errors = 0
      
      CSV.foreach(file_path, headers: true) do |row|
        begin
          # Find related records
          round = Round.find_by(name: row['round'])
          session = Session.find_by(sequence: row['session_sequence'].to_i)
          home_team = Team.find_by(name: row['home_team'])
          away_team = Team.find_by(name: row['away_team'])
          channel = Channel.find_by(number: row['channel_number'].to_i)
          
          # Skip if any required record is missing
          if round.nil?
            puts "\n⚠️ Round not found: #{row['round']}"
            errors += 1
            next
          end
          
          if session.nil?
            puts "\n⚠️ Session not found: sequence #{row['session_sequence']}"
            errors += 1
            next
          end
          
          if home_team.nil?
            puts "\n⚠️ Home team not found: #{row['home_team']}"
            errors += 1
            next
          end
          
          if away_team.nil?
            puts "\n⚠️ Away team not found: #{row['away_team']}"
            errors += 1
            next
          end
          
          # Create fixture
          fixture = Fixture.new(
            round: round,
            date: row['date'],
            session: session,
            home_team: home_team,
            away_team: away_team,
            channel: channel
          )
          
          if fixture.save
            count += 1
            print "."
          else
            errors += 1
            print "x"
            puts "\nError: #{fixture.errors.full_messages.join(', ')}"
          end
        rescue => e
          errors += 1
          print "!"
          puts "\nError with #{row['home_team']} vs #{row['away_team']}: #{e.message}"
        end
      end
      
      puts "\n✅ Imported #{count} fixtures"
      puts "⚠️  #{errors} errors" if errors > 0
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import results from CSV"
  task results: :environment do
    require 'csv'
    file_path = Rails.root.join('db/data/2026/results.csv')
    
    if File.exist?(file_path)
      count = 0
      skipped = 0
      
      CSV.foreach(file_path, headers: true) do |row|
        # Skip if no scores entered yet
        if row['home_goals'].blank? || row['away_goals'].blank?
          skipped += 1
          next
        end
        
        home_team = Team.find_by(name: row['fixture_home'])
        away_team = Team.find_by(name: row['fixture_away'])
        
        if home_team.nil?
          puts "\n⚠️ Home team not found: #{row['fixture_home']}"
          skipped += 1
          next
        end
        
        if away_team.nil?
          puts "\n⚠️ Away team not found: #{row['fixture_away']}"
          skipped += 1
          next
        end
        
        fixture = Fixture.find_by(home_team: home_team, away_team: away_team)
        
        if fixture.nil?
          puts "\n⚠️ Fixture not found: #{row['fixture_home']} vs #{row['fixture_away']}"
          skipped += 1
          next
        end
        
        result = Result.find_or_initialize_by(fixture: fixture)
        result.home_goals = row['home_goals'].to_i
        result.away_goals = row['away_goals'].to_i
        
        if result.save
          count += 1
          print "."
        else
          puts "\n❌ Error saving result for #{row['fixture_home']} vs #{row['fixture_away']}"
          skipped += 1
        end
      end
      
      puts "\n✅ Imported #{count} results"
      puts "⚠️  Skipped #{skipped} (no scores or missing data)" if skipped > 0
    else
      puts "❌ File not found: #{file_path}"
    end
  end

  desc "Import all data"
  task all: [:environment, :teams, :rounds, :sessions, :channels, :fixtures, :results] do
    puts "\n🎉 All imports completed!"
    puts "Teams: #{Team.count}"
    puts "Rounds: #{Round.count}"
    puts "Sessions: #{Session.count}"
    puts "Channels: #{Channel.count}"
    puts "Fixtures: #{Fixture.count}"
    puts "Results: #{Result.count}"
  end
  
  desc "Reset and import all data"
  task reset: :environment do
    puts "⚠️  This will delete all data! Are you sure? (y/n)"
    answer = STDIN.gets.chomp
    if answer.downcase == 'y'
      puts "Deleting all data..."
      Result.delete_all
      Fixture.delete_all
      Standing.delete_all
      Team.delete_all
      Round.delete_all
      Session.delete_all
      Channel.delete_all
      puts "✅ Data deleted"
      Rake::Task['import:all'].invoke
    else
      puts "Reset cancelled"
    end
  end
end