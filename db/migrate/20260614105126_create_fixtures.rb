class CreateFixtures < ActiveRecord::Migration[5.1]
  def change
    create_table :fixtures do |t|
      t.references :round, foreign_key: true
      t.date :date
      t.references :session, foreign_key: true
      t.references :home_team, foreign_key: { to_table: :teams }
      t.references :away_team, foreign_key: { to_table: :teams }
      t.references :channel, foreign_key: true

      t.timestamps
    end
  end
end
