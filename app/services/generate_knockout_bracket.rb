class GenerateKnockoutBracket
  R32_TO_R16 = { 1=>1, 2=>1, 3=>2, 4=>2, 5=>3, 6=>3, 7=>4, 8=>4, 9=>5, 10=>5, 11=>6, 12=>6, 13=>7, 14=>7, 15=>8, 16=>8 }
  R16_TO_QF  = { 1=>1, 2=>1, 3=>2, 4=>2, 5=>3, 6=>3, 7=>4, 8=>4 }
  QF_TO_SF   = { 1=>1, 2=>1, 3=>2, 4=>2 }
  SF_TO_FINAL = { 1=>1, 2=>1 }

  def self.call
    new.call
  end

  def call
    r32_matches = Fixture.where(round_id: 2).order(:date, :session_id).to_a
    if r32_matches.size != 16
      puts "⚠️  Expected 16 Round of 32 matches, found #{r32_matches.size}. Aborting."
      return
    end

    # Use existing knockout fixtures if they exist, otherwise create them.
    r16_matches = Fixture.where(round_id: 3).order(:id).to_a
    if r16_matches.empty?
      puts "Creating Round of 16 fixtures..."
      r16_matches = create_round_fixtures(3, 8)
    else
      puts "Using existing Round of 16 fixtures."
    end

    qf_matches = Fixture.where(round_id: 4).order(:id).to_a
    if qf_matches.empty?
      puts "Creating Quarter-final fixtures..."
      qf_matches = create_round_fixtures(4, 4)
    else
      puts "Using existing Quarter-final fixtures."
    end

    sf_matches = Fixture.where(round_id: 5).order(:id).to_a
    if sf_matches.empty?
      puts "Creating Semi-final fixtures..."
      sf_matches = create_round_fixtures(5, 2)
    else
      puts "Using existing Semi-final fixtures."
    end

    final_matches = Fixture.where(round_id: 6).order(:id).to_a
    if final_matches.empty?
      puts "Creating Final fixture..."
      final_matches = create_round_fixtures(6, 1)
    else
      puts "Using existing Final fixture."
    end
    final_match = final_matches.first

    # Link R32 -> R16
    r32_matches.each_with_index do |match, idx|
      r16_index = R32_TO_R16[idx + 1]
      r16_match = r16_matches[r16_index - 1]
      slot_in_pair = (idx % 2) + 1
      winner_slot = slot_in_pair == 1 ? 'home' : 'away'
      match.update!(next_match_id: r16_match.id, winner_slot: winner_slot)
    end

    # Link R16 -> QF
    r16_matches.each_with_index do |match, idx|
      qf_index = R16_TO_QF[idx + 1]
      qf_match = qf_matches[qf_index - 1]
      slot_in_pair = (idx % 2) + 1
      winner_slot = slot_in_pair == 1 ? 'home' : 'away'
      match.update!(next_match_id: qf_match.id, winner_slot: winner_slot)
    end

    # Link QF -> SF
    qf_matches.each_with_index do |match, idx|
      sf_index = QF_TO_SF[idx + 1]
      sf_match = sf_matches[sf_index - 1]
      slot_in_pair = (idx % 2) + 1
      winner_slot = slot_in_pair == 1 ? 'home' : 'away'
      match.update!(next_match_id: sf_match.id, winner_slot: winner_slot)
    end

    # Link SF -> Final
    sf_matches.each_with_index do |match, idx|
      slot_in_pair = (idx % 2) + 1
      winner_slot = slot_in_pair == 1 ? 'home' : 'away'
      match.update!(next_match_id: final_match.id, winner_slot: winner_slot)
    end

    puts "✅ Knockout bracket linked successfully!"
  end

  private

  def create_round_fixtures(round_id, count)
    round = Round.find(round_id)
    default_session = Session.first || Session.create!(sequence: 999, time: Time.now)
    default_date = Date.new(2026, 7, 5)
    default_team = Team.first

    count.times.map do
      Fixture.create!(
        round: round,
        date: default_date,
        session: default_session,
        home_team: default_team,
        away_team: default_team,
        channel_id: 1,
        criterium_id: 1
      )
    end
  end
end