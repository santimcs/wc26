class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.integer :sequence
      t.time :time

      t.timestamps
    end
  end
end
