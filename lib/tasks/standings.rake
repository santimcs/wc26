namespace :standings do
  desc "Initialize standings for all teams"
  task init: :environment do
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
    puts "✅ Initialized standings for #{Standing.count} teams"
  end
  
  desc "Recalculate standings from results"
  task recalc: :environment do
    Standing.delete_all
    Result.all.each do |result|
      result.send(:update_standings)
    end
    puts "✅ Recalculated standings for #{Standing.count} teams"
  end
end