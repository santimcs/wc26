class AddCriteriumToFixtures < ActiveRecord::Migration[5.1]
  def change
    add_reference :fixtures, :criterium, foreign_key: true, index: true
  end
end
