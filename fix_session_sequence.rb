# fix_session_sequence.rb
# Reassigns sequence values so they match time order (1..48)

# Get all sessions ordered by time
sessions = Session.order(:time)

# Update sequence based on position (1..48)
sessions.each_with_index do |session, index|
  new_sequence = index + 1
  if session.sequence != new_sequence
    session.update_column(:sequence, new_sequence)
    puts "Updated: ID #{session.id} -> sequence #{new_sequence} (time: #{session.time.strftime('%H:%M')})"
  end
end

puts "\n✅ Done! Sequence values are now synced with time order."
puts "First 5 sessions:"
Session.order(:sequence).limit(5).each do |s|
  puts "  #{s.sequence}: #{s.time.strftime('%H:%M')}"
end