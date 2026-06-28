class AddNextMatchToFixtures < ActiveRecord::Migration[5.1]
  def change
    add_reference :fixtures, :next_match, foreign_key: { to_table: :fixtures }
    add_column :fixtures, :winner_slot, :string  # 'home' or 'away'
  end
end
