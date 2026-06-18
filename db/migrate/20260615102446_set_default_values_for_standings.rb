# db/migrate/xxxxx_set_default_values_for_standings.rb
class SetDefaultValuesForStandings < ActiveRecord::Migration[5.1]
  def change
    change_column_default :standings, :played, 0
    change_column_default :standings, :wins, 0
    change_column_default :standings, :draws, 0
    change_column_default :standings, :losses, 0
    change_column_default :standings, :goals_for, 0
    change_column_default :standings, :goals_against, 0
    change_column_default :standings, :points, 0
  end
end