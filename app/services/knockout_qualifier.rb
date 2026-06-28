class KnockoutQualifier
  # Groups are A-L
  GROUPS = ('A'..'L').to_a

  def self.call
    new.call
  end

  def call
    # Clear previous entries if you want to re-run
    KnockoutTeam.delete_all

    all_third_place_teams = []

    GROUPS.each do |group|
      # Get standings for teams in this group (teams have a 'group' column)
      group_standings = Standing.joins(:team)
                                .where(teams: { group: group })
                                .order(points: :desc, goals_for: :desc, goals_against: :asc)
                                .to_a

      # In case of ties, you might need more logic (head-to-head), but this is a start.
      # Assign positions: 0=winner, 1=runner-up, 2=third-place
      group_standings.each_with_index do |standing, idx|
        position = idx # 0,1,2
        # Only top 3 matter; others are ignored
        break if position > 2

        team = standing.team
        attrs = {
          team: team,
          group_letter: group,
          position: position,
          seed_rank: nil,   # will set for third-place later
          bracket_slot: nil # can be assigned later if needed
        }

        if position == 2
          # Store third-place team for later ranking
          all_third_place_teams << { standing: standing, attrs: attrs }
        else
          KnockoutTeam.create!(attrs)
        end
      end
    end

    # Now rank third-place teams and keep top 8
    ranked_third = all_third_place_teams.sort_by do |item|
      s = item[:standing]
      [-s.points, -s.goals_for, s.goals_against] # descending points, descending GF, ascending GA
    end

    ranked_third.first(8).each_with_index do |item, index|
      attrs = item[:attrs]
      attrs[:seed_rank] = index + 1
      KnockoutTeam.create!(attrs)
    end

    # Optionally, assign bracket_slot based on a fixed mapping or fixture order
    # You can do that in a separate step.

    puts "✅ Knockout teams populated: #{KnockoutTeam.count} teams"
  end
end