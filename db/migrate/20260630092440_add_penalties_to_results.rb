class AddPenaltiesToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :home_penalties, :integer
    add_column :results, :away_penalties, :integer
  end
end
