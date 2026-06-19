# update_sessions.rb (Rails 5 compatible)
# Replaces sessions with 48 half-hour slots (00:00..23:30) while preserving fixtures.

require 'active_record'

# ------------------------------------------------------------------
# 1. Build the new sessions data (48 records)
# ------------------------------------------------------------------
new_sessions = []
(0..23).each do |hour|
  (0..1).each do |half|
    minute = half == 0 ? 0 : 30
    time = Time.new(2000, 1, 1, hour, minute, 0)
    sequence = hour * 2 + half + 1  # 1..48
    new_sessions << {
      sequence: sequence,
      time: time
    }
  end
end

# ------------------------------------------------------------------
# 2. Insert new sessions one by one (Rails 5 compatible)
# ------------------------------------------------------------------
created_sessions = []
new_sessions.each do |attrs|
  session = Session.create!(sequence: attrs[:sequence], time: attrs[:time])
  created_sessions << session
end

# Build a mapping from time string (HH:MM:SS) to new id
time_to_new_id = {}
created_sessions.each do |session|
  time_str = session.time.strftime("%H:%M:%S")
  time_to_new_id[time_str] = session.id
end

puts "✅ Created #{created_sessions.count} new sessions"

# ------------------------------------------------------------------
# 3. Update fixtures to point to the new session ids
# ------------------------------------------------------------------
fixtures = Fixture.where.not(session_id: nil)
updated = 0
fixtures.each do |fixture|
  old_session = Session.find_by(id: fixture.session_id)
  next unless old_session

  old_time_str = old_session.time.strftime("%H:%M:%S")
  new_id = time_to_new_id[old_time_str]

  if new_id
    fixture.update_column(:session_id, new_id)
    updated += 1
  else
    # This should never happen because all old times are multiples of 30 min
    fixture.update_column(:session_id, nil)
    puts "⚠️  No match for time #{old_time_str} – set to NULL"
  end
end

puts "✅ Updated #{updated} fixtures to use new session ids"

# ------------------------------------------------------------------
# 4. Delete the old sessions (they are no longer referenced)
# ------------------------------------------------------------------
# The old sessions are the ones not in the new set.
old_session_ids = Session.where.not(id: created_sessions.map(&:id)).pluck(:id)
if old_session_ids.any?
  Session.where(id: old_session_ids).delete_all
  puts "✅ Deleted #{old_session_ids.count} old sessions"
else
  puts "ℹ️  No old sessions to delete"
end

# ------------------------------------------------------------------
# 5. Reset the id sequence (optional)
# ------------------------------------------------------------------
max_id = Session.maximum(:id)
if max_id
  ActiveRecord::Base.connection.reset_pk_sequence!('sessions')
  puts "✅ Reset sessions id sequence"
end

# ------------------------------------------------------------------
# 6. Verify
# ------------------------------------------------------------------
puts "🎉 Done! Current sessions: #{Session.count}"
puts "First few sessions:"
Session.order(:sequence).limit(10).each do |s|
  puts "  #{s.sequence}: #{s.time.strftime('%H:%M')}"
end