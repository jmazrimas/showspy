class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :artist
      t.datetime :date
      t.integer :venue_id
      t.integer :match_level
      t.timestamps
    end
  end
end
