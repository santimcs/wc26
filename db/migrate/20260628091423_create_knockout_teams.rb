class CreateKnockoutTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :knockout_teams do |t|
      t.references :team, foreign_key: true, null: false
      t.string :group_letter, limit: 1, null: false
      t.integer :position, null: false  # 0 = winner, 1 = runner-up, 2 = third-place
      t.integer :seed_rank              # 1..8 for third-place teams, NULL for others
      t.integer :bracket_slot #, null: false  # 1..32

      t.timestamps
    end

    add_index :knockout_teams, :bracket_slot, unique: true
    add_index :knockout_teams, [:team_id, :group_letter], unique: true
  end
end
