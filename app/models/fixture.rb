class Fixture < ApplicationRecord
  belongs_to :round
  belongs_to :session

  belongs_to :channel
  belongs_to :criterium, optional: true
  belongs_to :next_match, class_name: 'Fixture', optional: true
  belongs_to :home_team, class_name: 'Team', optional: true
  belongs_to :away_team, class_name: 'Team', optional: true
  validates :date, presence: true
  
  def display_name
    "#{date.strftime('%b %d')}: #{home_team.name} vs #{away_team.name} (#{round.name})"
  end
end