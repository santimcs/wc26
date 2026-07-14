class AddFormToStandings < ActiveRecord::Migration[5.1]
  def change
    add_column :standings, :form, :string
  end
end
